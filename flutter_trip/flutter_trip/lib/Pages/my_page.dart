import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/webview.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();

}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            _header,
            _wallet,
          ],
        ),
      ),
    );
  }
  Widget get _header {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
      padding: EdgeInsets.only(top: 80),
      child: Center(
        child: Column(
          children: <Widget>[
            Text('登录携程，开启旅程',style: TextStyle(color: Colors.white,fontSize: 18),),
            _loganView,
          ],
        ),
      ),
    );
  }

  Widget get _wallet{
    BorderSide borderSide = BorderSide(width: 1,color: Color(0xfff2f2f2));
    return Container(
      height: 75,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context,color: Color(0xfff2f2f2)),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.public,color: Colors.grey,),
          Container(
            height: 55,
            padding: EdgeInsets.only(left: 10),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text('钱包',style: TextStyle(fontSize: 18),),
               Container(
                 child: Row(
                   children: <Widget>[
                     Text('礼品卡   |  现金   |   返现',style: TextStyle(color: Colors.grey,fontSize: 16),),
                   ],
                 ),
               ),
             ],
           ),
          ),
        ],
      ),
    );
  }


  Widget get _loganView {
    return Container(
      height: 80,
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 40,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.orange,
            ),
            child: GestureDetector(
              onTap: (){
              },
              child: Text('登录/注册',style: TextStyle(color: Colors.white,fontSize: 15),),
            ),
          ),
          Container(
            height: 40,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: (){
              },
              child: Text('手机号查单',style: TextStyle(color: Colors.white,fontSize: 15),),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _webView {
    return WebView(
      url: 'https://m.ctrip.com/webapp/myctrip/',
      hideAppBar: true,
      backForbid: true,
      statusBarColor: '4c5bca',
    );
  }
}