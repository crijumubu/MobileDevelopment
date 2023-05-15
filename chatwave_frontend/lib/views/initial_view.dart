import 'dart:math';

import 'package:flutter/material.dart';
import 'register.dart';
import '../global.dart';

class IntialView extends StatelessWidget {
  const IntialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Chatwave",
            style: logo,
          )),
          const SizedBox(
            height: 20,
          ),
          Boton(
              onPress: () {
                Navigator.pushNamed(context, "/register");
              },
              text: "Registrarme"),
          Boton(
              onPress: () {
                Navigator.pushNamed(context, "/login");
              },
              text: "Iniciar sesión")
        ],
      ),
    );
  }
}
