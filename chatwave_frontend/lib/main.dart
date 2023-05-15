import 'package:flutter/material.dart';
import 'controller/controller.dart';
import 'views/buzon.dart';
import 'views/home.dart';
import 'views/initial_view.dart';
import 'views/login.dart';
import 'views/mensaje.dart';
import 'views/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Controller controller = Controller();
  controller.sesion().then((value) {
    runApp(MyApp(
      init: value,
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.init});

  final String init;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Chatwave',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      routes: {
        "initial": (context) => const IntialView(),
        "home": (context) => const Home(),
        "/login": (context) => Login(),
        "/register": (context) => const Register(),
        "/buzon": (context) => Buzon(),
        "/mensaje": (context) => Mensaje(),
      },
      initialRoute: init,
      debugShowCheckedModeBanner: false,
    );
  }
}
