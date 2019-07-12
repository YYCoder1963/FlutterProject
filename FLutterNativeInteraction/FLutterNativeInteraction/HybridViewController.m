//
//  HybridViewController.m
//  FLutterHybridDemo
//
//  Created by lyy on 2019/5/14.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "HybridViewController.h"
#import <Flutter/Flutter.h>

static NSString *const kMessageChannelName = @"BasicMessageChannel";
static NSString *const kEventChannelName = @"EventChannel";
static NSString *const kMethodChannelName = @"MethodChannel";

@interface HybridViewController ()<UITextFieldDelegate,FlutterStreamHandler>
@property(strong,nonatomic)FlutterViewController *flutterController;
@property (nonatomic) FlutterBasicMessageChannel* messageChannel;
@property (nonatomic) FlutterEventChannel* eventChannel;
@property (nonatomic) FlutterMethodChannel* methodChannel;
@property (nonatomic) FlutterEventSink eventSink;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendLabel;
@property(assign,nonatomic)BOOL useMesageChannel;


@end

@implementation HybridViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationItem.title = @"This is Native";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.useMesageChannel = YES;
    [self initChannel];
    [self setUpSubController];
}

- (void)initBasicMessageChannel {
    self.messageChannel = [FlutterBasicMessageChannel messageChannelWithName:kMessageChannelName binaryMessenger:self.flutterController codec:[FlutterStringCodec sharedInstance]];
    __weak typeof(self) weakSelf = self;
    //设置消息处理器，处理来自Dart的消息
    [self.messageChannel setMessageHandler:^(NSString* message, FlutterReply reply) {
        reply([NSString stringWithFormat:@"MessageChannel收到Dart信息：%@",message]);
        [weakSelf showMessage:[NSString stringWithFormat:@"收到Dart消息:%@ by BasicMessageChannel",message]];
    }];
}

- (void)sendMessageByBasicMessageChannel:(NSString *)message{
    [self.messageChannel sendMessage:message reply:^(id  _Nullable reply) {
        if (reply) {
            [self showMessage:[NSString stringWithFormat:@"收到Dart回复:%@ by BasicMessageChannel",message]];
        }
    }];
}



- (void)initMethodChannel {
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:kMethodChannelName binaryMessenger:self.flutterController];
    __weak typeof(HybridViewController) *weakSelf = self;
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"send"]) {//调用哪个方法
            result([NSString stringWithFormat:@"MethodChannel:收到Dart消息：%@",call.arguments]);
            [weakSelf showMessage:[NSString stringWithFormat:@"收到Dart消息:%@ by MethodChannel",call.arguments]];
        }
    }];
}



- (void)initEventChannel {
    self.eventChannel = [FlutterEventChannel eventChannelWithName:kEventChannelName binaryMessenger:self.flutterController];
    [self.eventChannel setStreamHandler:self];
}

- (void)sendMessageByEventChannel:(NSString *)message{
    if (self.eventSink) {
        self.eventSink(message);
    }
}

- (void)showMessage:(NSString *)message {
    self.showLabel.text = message;
}

- (IBAction)editingChanged:(id)sender {
    if (self.useMesageChannel) {
        [self sendMessageByBasicMessageChannel:self.textField.text];
    }else {
        [self sendMessageByEventChannel:self.textField.text];
    }
    
}

- (IBAction)switch:(UISwitch *)sender {
    self.useMesageChannel = sender.isOn;
    self.sendLabel.text = !sender.isOn ? @"EventChannel" : @"MessageChannel";
    [self showMessage:@"tips"];
}

- (void)initChannel {
    [self initBasicMessageChannel];
    [self initEventChannel];
    [self initMethodChannel];
}

- (void)setUpSubController {
    [self addChildViewController:self.flutterController];
    UIView *subView = self.flutterController.view;
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    subView.frame = CGRectMake(0, 300, self.view.bounds.size.width, self.view.bounds.size.height-300);
    [self.view addSubview:subView];
}

- (FlutterViewController *)flutterController {
    if (!_flutterController) {
        _flutterController = [[FlutterViewController alloc]init];
        [_flutterController setInitialRoute:@"default"];
    }
    return _flutterController;
}


#pragma mark - <FlutterStreamHandler>
//这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(FlutterEventSink)eventSink {
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    self.eventSink = eventSink;
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    self.eventSink = nil;
    return nil;
}

@end
