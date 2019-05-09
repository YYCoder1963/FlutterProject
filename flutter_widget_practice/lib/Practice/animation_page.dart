import 'package:flutter/material.dart';

//void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget{
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationState;
  double animationValue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0,end: 300).animate(controller)
    ..addListener((){
      setState(() {
        animationValue = animation.value;
      });
    })
    ..addStatusListener((AnimationStatus state){
      setState(() {
        animationState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('如何为Widget添加动画'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  controller.reset();
                  controller.forward();
                },
                child: Text('Start',textDirection: TextDirection.ltr),
              ),
              Text(
                'State:'+animationState.toString(),
                textDirection: TextDirection.ltr,
              ),
              Text(
                'Value:'+animationValue.toString(),
                textDirection: TextDirection.ltr,
              ),
              Container(
                height: animation.value,
                width: animation.value,
                child: FlutterLogo(),
              ),
            ],
          ),
        )
      ),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}