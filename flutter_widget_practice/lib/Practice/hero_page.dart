import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HeroPage extends StatefulWidget{
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> with SingleTickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context){
    return HeroAnimation();
  }
}

class PhotoHero extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  const PhotoHero({Key key,this.photo,this.onTap,this.width}):super(key:key);

  Widget build(BuildContext context){
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(photo,fit: BoxFit.contain,),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  Widget build(BuildContext context){
    timeDilation = 5.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'https://pics3.baidu.com/feed/2fdda3cc7cd98d109c8c648a9c7b7b0a7aec90fe.jpeg?token=e3d0927bb2355d66e2235417f1b27a88&s=D62006E098D819CE2A183C51030010D0',
          width: 300.0,
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Flippers Page'),
                ),
                body: Container(
                  color: Colors.lightBlue,
                  padding: const EdgeInsets.all(15.0),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo: 'https://pics3.baidu.com/feed/2fdda3cc7cd98d109c8c648a9c7b7b0a7aec90fe.jpeg?token=e3d0927bb2355d66e2235417f1b27a88&s=D62006E098D819CE2A183C51030010D0',
                    width: 150.0,
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}