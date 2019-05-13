import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencePage extends StatefulWidget{
  @override
  _SharePreferencePageState createState() => _SharePreferencePageState();
}

class _SharePreferencePageState extends State<SharePreferencePage> {
  String countString = '';
  String localCount = '';
  final String prefsKey = 'counter';
  @override
  Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text('SharedPreferences Practice'),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: _incrementCounter,
                  child: Text('increment counter'),
                ),
                RaisedButton(
                  onPressed: _getCounter,
                  child: Text('get counter'),
                ),
                Text(
                  countString,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'result:' + localCount,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      );
    }


    _incrementCounter() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        countString = countString + "1";
      });
      int counter = (prefs.getInt(prefsKey)?? 0) +1;
      await prefs.setInt(prefsKey, counter);
    }
    
    _getCounter() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        localCount = prefs.getInt(prefsKey).toString();
      });
    }
}
