import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github_api_app/model/users.dart';

class ApiUser {
  static Future<List<Users>> getUsers(int page) async {
    var url = Uri.parse(
        "https://api.github.com/users?per_page=10&since=" + page.toString());
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    // List<dynamic> listUser = (json as Map<String, dynamic>);
    // final parsed = json.cast<Map<String, dynamic>>();
    // print(object)
    if (response.statusCode == 200) {
      List<Users> listUser = [];

      json.forEach((item) {
        listUser.add(Users.fromJson(item));
      });
      return Future.value(listUser);
    } else {
      return Future.error(
      Exception("Request failed with status: ${response.statusCode}."));
    }
  }

  static Future<List<Users>> searchUsers(String search) async {
    var url = Uri.parse("https://api.github.com/search/users?q=" + search);
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List<dynamic> listUser = (json as Map<String, dynamic>)['items'];
        List<Users> user = [];

        listUser.forEach((item) {
          user.add(Users.fromJson(item));
        });
        print(user.toString());
        return user;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<Users> detailUser(String username) async {
    var url = Uri.parse("https://api.github.com/users/" + username);
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return Users.fromJson(json);
  }
}