import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../model/imessage.dart';
import '../model/iuser.dart';

class Controller {
  final _url = "http://10.153.56.230:1802/chatwave/api";
  final headers = {"Content-type": 'application/json'};

  Future<AlertDialog> register(context, String name, String email, String pass,
      String phone, String position, XFile img) async {
    List<int> imgBytes = await img.readAsBytes();
    String image = base64Encode(imgBytes);

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcMToken = await messaging.getToken();

    var body = jsonEncode({
      "name": name,
      "email": email,
      "password": pass,
      "phone": phone,
      "position": position,
      "photo": image,
      "fcmToken": fcMToken
    });

    var response = await http.post(Uri.parse("$_url/register"),
        headers: headers, body: body);

    return AlertDialog(
      title: const Text("Resultado"),
      content: Text(jsonDecode(response.body)["message"]),
      actions: [
        TextButton(
            onPressed: () {
              if (response.statusCode == 200) {
                Navigator.popUntil(context, ModalRoute.withName('initial'));
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text("OK"))
      ],
    );
  }

  Future login(context, String email, String password) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcMToken = await messaging.getToken();

    if (fcMToken == null) {
      return "Error FCM TOKEN.";
    }

    var body = jsonEncode(
        {"email": email, "password": password, "fcmToken": fcMToken});

    var response =
        await http.post(Uri.parse("$_url/login"), headers: headers, body: body);

    if (response.statusCode == 200) {
      SharedPreferences shPre = await SharedPreferences.getInstance();
      String? authToken = response.headers["auth-token"];

      if (authToken == null) return "Error AuthToken";

      shPre.setString("token", authToken);
      return null;
    } else if (response.statusCode == 401) {
      return "Credenciales incorrectas.";
    }
    return "Error ${response.statusCode}";
  }

  Future<String> sesion() async {
    SharedPreferences shPre = await SharedPreferences.getInstance();
    String? token = shPre.getString("token");

    if (token != null){

      return "home";
    }

    return "initial";
  }

  Future users() async {
    SharedPreferences shPre = await SharedPreferences.getInstance();
    String? token = shPre.getString("token");

    if (token == null) return "Error token";

    final headerToken = {
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
      Uri.parse("$_url/users"),
      headers: headerToken,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<IUser> users = [];

      for (var user in data){

        users.add(IUser(foto: user['photo'], nombre: user['name'], email: user['email'], numero: user['phone'], cargo: user['position']));
      }
      return users;
    }

    return "Error";
  }

  Future endSesion() async {
    SharedPreferences shPre = await SharedPreferences.getInstance();
    shPre.remove("token");
  }

  Future getBuzon(email) async {
    SharedPreferences shPre = await SharedPreferences.getInstance();
    String? token = shPre.getString("token");

    if (token == null) return "Error token";

    final headerToken = {
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
      Uri.parse("$_url/received/messages/$email"),
      headers: headerToken,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<IMessage> mensajes = [];

      for (var message in data){

        mensajes.add(IMessage(de: message['from'], para: message['to'], asunto: message['subject'], mensaje: message['message']));
      }
      return mensajes;
    }
    return "Error";
  }

  Future sendMessage(String para, String asunto, String mensaje) async {
    SharedPreferences shPre = await SharedPreferences.getInstance();
    String? token = shPre.getString("token");
    if (token == null) return "Error token";

    final headerToken = {
      'Authorization': 'Bearer $token',
      "Content-type": 'application/json'
    };

    var body = jsonEncode({"to": para, "subject": asunto, "message": mensaje});

    var response = await http.post(Uri.parse("$_url/message"),
        headers: headerToken, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["message"];
    }
    return "Error: ${jsonDecode(response.body)["message"]}";
  }
}
