import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('搜索'),
      ),
    );
  }
}