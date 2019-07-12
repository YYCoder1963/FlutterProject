import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_trip/model/home_model.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao{
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      HomeModel model = HomeModel.fromJson(result);
      print(model.bannerList);
      print(model.salesBox);
      print(model.gridNav);
      print(model.subNavList);
      print(model.localNavList);
      return model;
    }else{
      throw Exception('Failed to load home_page.json111');
    }
  }
}