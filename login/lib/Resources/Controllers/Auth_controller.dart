import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController {

  Future loginUser(String email, String password) async{

    const url = 'http://192.168.12.20:1802/api/users/login';

    var response = await http.post(Uri.parse(url), body: {
      "email": email,
      "password": password
    });

    if (response.statusCode == 200){

      var loginResponse = json.decode(response.body);
      String token = loginResponse['data']['token'];
      storeToken(token);
    }else{
      print("Login Error");
    }
  }

  checkToken(String token) async{

    const url = 'http://192.168.12.20:1802/api/users/sesion';

    var response = await http.post(Uri.parse(url), body: {
      "token": token,
    });

    if (response.statusCode == 200){

      return true;
    }else{

      return false;
    }
  }

  storeToken(String token) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('jwt', token);
  }

  getToken() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('jwt');

    if (token != null){

      return token;
    }
  }

  removeToken() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('jwt');
  }
}