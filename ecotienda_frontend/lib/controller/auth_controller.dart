import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/alerts.dart';
import 'package:frontend/view/widgets/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../model/database.dart';

class AuthController{
  final _url = "http://mienvio2.bucaramanga.upb.edu.co:1802/ecotienda/api"; 
  late SharedPreferences shPref;

  Future register(dynamic context, String user, String pass) async{
    var response = await http.post(Uri.parse("$_url/register"), body:{
      "email": user,
      "password": pass,
    });

    if(response.statusCode == 200){
      succesfulAlert(context, "Registro Exitoso");
      Future.delayed(const Duration(seconds: 2, milliseconds: 500),(){
        Navigator.pushNamed(context, "login-register").then((value) => null);
      });
      
    }else if(response.statusCode == 409){
      errorAlert(context, "El usuario ya se encuentra en uso!");
    }
  }

  Future login(dynamic context, String email, String pass, ) async{
    shPref = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse("$_url/login"), body:{
      "email": email,
      "password": pass,
    });

    if(response.statusCode == 200){
      var loginArr = json.decode(response.body);
      shPref.setString("token", loginArr["data"]["token"]);
      shPref.setString("username", loginArr["data"]["email"]);

      await getFavorites().then((value) async => await DatabaseHelper.instance.addProducts(value));
      
      Navigator.pushNamed(context, "/home-supervisor");
    }else{
      errorAlert(context, "Credenciales incorrectas");
      // print("Wrong Credentials");
    }
  }

  Future postFavorites(Map<String,dynamic> body) async{
    shPref = await SharedPreferences.getInstance();
    String?  token =  shPref.getString("token");
    Map<String,String> header = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json; charset=UTF-8',};

    var response = await http.post(Uri.parse("$_url/favorite"), headers: header, body: json.encode(body));
    if(response.statusCode == 200){
      return Future.value(200);
    }
    return Future.value(403);
  }

  Future closeSession() async{
    

    await DatabaseHelper.instance.postProductsFavorites();
    await DatabaseHelper.instance.deleteData();
    await DatabaseHelper.instance.getProductsFavorites();

    shPref = await SharedPreferences.getInstance();
    await shPref.remove("token");
    await shPref.remove("username");



  }

  Future getUsername() async{
    shPref = await SharedPreferences.getInstance();
    String?  user =  shPref.getString("username");

    return Future.value(user);
  }

  
  Future getProducts(context) async{
    shPref = await SharedPreferences.getInstance();
    String?  token =  shPref.getString("token");
    print(token);
    Map<String,String> header = {'Authorization': 'Bearer $token'};

    var response = await http.get(Uri.parse("$_url/products"), headers: header);

    if(response.statusCode == 200){
      List<dynamic> data = json.decode(response.body);
      // print(data);
      return Future.value(data);
    }
    closeSession();

    Navigator.pushNamed(context, "login-register").then((value) => null);
    Future.delayed(const Duration(milliseconds: 500),(){
      errorAlert(context, "Sesion expirada, por favor inicie sesion.", time: 3);
    });
    
    return Future.value(null);
  }

  Future getFavorites() async{
    shPref = await SharedPreferences.getInstance();
    String?  token =  shPref.getString("token");
    Map<String,String> header = {'Authorization': 'Bearer $token'};

    var response = await http.get(Uri.parse("$_url/favorites"), headers: header);

    if(response.statusCode == 200){
      try {
        List<dynamic> data = json.decode(response.body);
        print(data);
        return Future.value(data);
      } catch (e) {
        return Future.value([]);
        
      }
      
    }

    return Future.value(null);
  }

  Future checkSession() async{
    shPref = await SharedPreferences.getInstance();
    String?  token =  shPref.getString("token");
    Map<String,String> header = {'Authorization': 'Bearer $token'};
    var response = await http.get(Uri.parse("$_url/products"), headers: header);

    if(response.statusCode == 200){
      return Future.value(true);
    }
    closeSession();
    
    return Future.value(false);
  }


}