import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/Practice/FlutterLayoutPage.dart';
import 'package:flutter_widget_practice/Practice/gesture_page.dart';
import 'package:flutter_widget_practice/Practice/hero_page.dart';
import 'package:flutter_widget_practice/Practice/launch_page.dart';
import 'package:flutter_widget_practice/Practice/photo_app_page.dart';
import 'package:flutter_widget_practice/Practice/animation_page.dart';
import 'package:flutter_widget_practice/Practice/animationWidget_page.dart';
import 'package:flutter_widget_practice/Practice/rectTween_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: TabNavigator(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('如何创建和使用FLutter路由与导航'),
        ),
        body: RouteNavigator(),
      ),
      routes: <String,WidgetBuilder>{
        'hero':(BuildContext context) => HeroPage(),
        'layout':(BuildContext context) => FlutterLayoutPage(),
        'gesture':(BuildContext context) => GesturePage(),
        'launch':(BuildContext context) => LaunchPage(),
        'photo':(BuildContext context) => PhotoApp(),
        'animation':(BuildContext context) => LogoApp(),
        'animationWidget':(BuildContext context) => AnimatedLogoApp(),
        'rectTween':(BuildContext context) => RectTweenPage(),
      },
    );
  }
}

class RouteNavigator extends StatefulWidget{
  @override
  _RouteNavigatorState createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;
  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile(
            title: Text('${byName ? '':'不'}通过路由名跳转'),
            value: byName,
            onChanged: (value){
              setState(() {
                byName = value;
              });
            },
          ),
          _item('hero use', HeroPage(), 'hero'),
          _item('如何进行Flutter布局开发', FlutterLayoutPage(), 'layout'),
          _item('如何检测用户手势以及处理点击事件？', GesturePage(), 'gesture'),
          _item('如何打开第三方应用？', LaunchPage(), 'launch'),
          _item('【实战尝鲜】拍照APP', PhotoApp(), 'photo'),
          _item('动画', LogoApp(), 'animation'),
          _item('animationWidget', AnimatedLogoApp(), 'animationWidget'),
          _item('RectTween Practice', RectTweenPage(), 'rectTween'),
        ],
      ),
    );
  }
  _item(String title, page,String routeName){
    return Container(
      child: RaisedButton(
        onPressed: (){
          if(byName){
            Navigator.pushNamed(context, routeName);
          }  else{
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}


