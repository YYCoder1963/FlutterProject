import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

class RectTweenPage extends StatefulWidget {

  _RectTweenPageState createState() => _RectTweenPageState();
}

class _RectTweenPageState extends State<RectTweenPage> with SingleTickerProviderStateMixin {

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('RectTween Practice'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: RadialExpansionDemo(),
      ),
    );
  }
}


class Photo extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  const Photo({Key key,this.photo,this.onTap,this.width}):super(key:key);

  Widget build(BuildContext context){
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(builder: (context,size) {
          return Image.network(
            photo,
            fit: BoxFit.contain,
          );
        }),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  final double maxRadius;
  final clipRectSize;
  final Widget child;
  RadialExpansion({Key key,this.maxRadius,this.child}):clipRectSize = 2.0*(maxRadius/math.sqrt2),super(key:key);

  @override
  Widget build(BuildContext context){
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }

}

class RadialExpansionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve = const Interval(0.0, 0.75,curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect begin,Rect end){
    return MaterialRectCenterArcTween(begin: begin,end: end);
  }

  static Widget _buildPage(BuildContext context,String imageName,String description){
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: kMaxRadius*2.0,
                height: kMaxRadius*2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 16.0,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context,String imageName,String description){
    return Container(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
          createRectTween: _createRectTween,
          tag: imageName,
          child: RadialExpansion(
            maxRadius: kMaxRadius,
            child: Photo(
              photo: imageName,
              onTap: () {
                Navigator.of(context).push(
                    PageRouteBuilder<void>(
                        pageBuilder: (BuildContext context,Animation<double>animation,Animation<double>secondaryAnimation){
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (BuildContext context,Widget child){
                              return Opacity(
                                opacity: opacityCurve.transform(animation.value),
                                child: _buildPage(context, imageName, description),
                              );
                            },
                          );
                        })
                );
              },
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Transition Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildHero(context, 'https://pics3.baidu.com/feed/2fdda3cc7cd98d109c8c648a9c7b7b0a7aec90fe.jpeg?token=e3d0927bb2355d66e2235417f1b27a88&s=D62006E098D819CE2A183C51030010D0', 'first'),
            _buildHero(context, 'https://pics3.baidu.com/feed/2fdda3cc7cd98d109c8c648a9c7b7b0a7aec90fe.jpeg?token=e3d0927bb2355d66e2235417f1b27a88&s=D62006E098D819CE2A183C51030010D0', 'second'),
            _buildHero(context, 'https://pics3.baidu.com/feed/2fdda3cc7cd98d109c8c648a9c7b7b0a7aec90fe.jpeg?token=e3d0927bb2355d66e2235417f1b27a88&s=D62006E098D819CE2A183C51030010D0', 'third'),
          ],
        ),
      ),
    );
  }
}