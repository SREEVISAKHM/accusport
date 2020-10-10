import 'package:http/http.dart' as http;
import 'package:sports/const/const.dart';
import 'dart:convert';
import 'package:sports/data/data.dart';

class API {
  Future<UserModel> getdata() async {
    var client = http.Client();
    var userModel = null;

    try {
      var response = await client.get(Strings.url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        userModel = UserModel.fromJson(jsonMap);
      }
    } catch (e) {
      return userModel;
    }
    return userModel;
  }
}
