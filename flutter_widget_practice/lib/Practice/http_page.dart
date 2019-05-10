import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpPage extends StatefulWidget{
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> with SingleTickerProviderStateMixin {

  String showResult = '';
  Future<CommonModel> fetchPost() async {
    final response = await http.get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    Utf8Decoder utf8decoder = Utf8Decoder();//json编解码
    final result = json.decode(utf8decoder.convert(response.bodyBytes));//转中文
    return CommonModel.fromJson(result);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Future与FutureBuilder使用'),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder<CommonModel>(
                future: fetchPost(),
                builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                      return Text('Input a url');
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator(),);
                    case ConnectionState.active:
                      return Text('');
                    case ConnectionState.done:
                      if(snapshot.hasError){
                        return Text('');
                      }else{
                        return Column(
                          children: <Widget>[
                            Text('hideAPPBar:${snapshot.data.hideAppBar}'),
                            Text('icon:${snapshot.data.icon}'),
                            Text('url:${snapshot.data.url}'),
                            Text('title:${snapshot.data.title}'),
                            Text('statusBarColor:${snapshot.data.statusBarColor}'),
                          ],
                        );
                      }
                  }
                }),
            InkWell(
              onTap: (){
                fetchPost().then((CommonModel value){
                  setState(() {
                    showResult = ' 请求结果: \n hideAPPBar:${value.hideAppBar},\n icon:${value.icon}, \n url:${value.url},\n title:${value.title},\n statusBarColor:${value.statusBarColor}';
                  });
                });
              },
              child: Text('click',style: TextStyle(fontSize: 25),),
            ),
            Text(showResult),
          ],
        )
    );
  }
}

class CommonModel{
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({this.icon,this.title,this.url,this.statusBarColor,this.hideAppBar});
  factory CommonModel.fromJson(Map<String,dynamic>json){
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}