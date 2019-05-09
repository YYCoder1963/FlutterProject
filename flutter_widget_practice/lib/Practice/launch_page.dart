import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchPage extends StatefulWidget{
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('如何打开第三方应用'),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _launchUrl(),
              child: Text('打开浏览器'),
            ),
            RaisedButton(
              onPressed: () => _openMap(),
              child: Text('打开地图'),
            ),
          ],
        ),
      ),
    );
  }
}

_launchUrl() async {
  const url = 'http://www.devio.org/';
  if(await canLaunch(url)){
    await launch(url);
  }else{
    throw 'could not launch $url';
  }
}

_openMap() async {
  const url = 'geo:52.52,4.20';
  if(await canLaunch(url)) {
    await launch(url);
  }else{
    const url = 'http://map.apple.com/?ll=52.52,4.20';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'could not launch $url';
    }
  }
}
