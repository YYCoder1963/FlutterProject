import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key,Animation<double> animation}):super(key:key,listenable:animation);
  Widget build(BuildContext context){
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}

class AnimatedLogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<AnimatedLogoApp> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(vsync: this,duration: const Duration(milliseconds: 2000));
    animation = new Tween(begin: 0.0,end: 300.0).animate(controller);
    controller.forward();
  }
  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('使用'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: AnimatedLogo(animation: animation),
    );
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}