import 'dart:convert';

import 'package:flutter/material.dart';
import 'user.dart';
import '../controller/controller.dart';
import '../global.dart';
import '../model/iuser.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Controller _controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text("Chat", style: appbar),
        actions: [
          IconButton(
              onPressed: () {
                _controller.endSesion();
                Navigator.pushReplacementNamed(context, "initial");
              },
              icon: const Icon(
                Icons.logout_outlined,
                size: 30,
                weight: 5,
              ))
        ],
      ),
      body: FutureBuilder(
        future: _controller.users(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is String) {
              return Center(
                child: Text(snapshot.data),
              );
            }
            List<IUser> usuariosBD = snapshot.data as List<IUser>;
            return ListView.separated(
                itemCount: usuariosBD.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return UserList(usuario: usuariosBD[index]);
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("No hay más usuarios en el sistema\n por el momento.", textAlign: TextAlign.center,),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({
    super.key,
    required this.usuario,
  });

  final IUser usuario;

  @override
  Widget build(BuildContext context) {
    final img = base64Decode(usuario.foto);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: MemoryImage(img),
        radius: 28,
      ),
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => User(usuario: usuario))),
    );
  }
}
