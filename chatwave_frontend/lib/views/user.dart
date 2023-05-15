import 'dart:convert';

import 'package:flutter/material.dart';
import 'register.dart';
import '../global.dart';
import '../model/iuser.dart';

class User extends StatelessWidget {
  const User({super.key, required this.usuario});

  final IUser usuario;

  @override
  Widget build(BuildContext context) {
    final img = base64Decode(usuario.foto);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Column(children: [
            Text(usuario.nombre, style: appbar),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundImage: MemoryImage(img),
              radius: 120,
            )
          ]),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Numero: ",
                      style: tituloContacto,
                    ),
                    Text(
                      usuario.numero,
                      style: infoContacto,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Email: ",
                      style: tituloContacto,
                    ),
                    Text(
                      usuario.email,
                      style: infoContacto,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Cargo: ",
                      style: tituloContacto,
                    ),
                    Text(
                      usuario.cargo,
                      style: infoContacto,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Boton(
                    onPress: () {
                      Navigator.pushNamed(context, "/buzon",
                          arguments: usuario.email);
                    },
                    text: "Ver buzón"),
                // Spacer()
                const SizedBox(
                  width: 20,
                ),
                Boton(
                    onPress: () {
                      Navigator.pushNamed(context, "/mensaje",
                          arguments: usuario.email);
                    },
                    text: "Enviar mensaje")
              ],
            ),
          )
        ],
      ),
    );
  }
}
