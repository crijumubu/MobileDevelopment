import 'package:flutter/material.dart';
import 'package:login/Resources/Views/App.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(

      title: 'Login',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const App(title: 'Iniciar sesión'),
      debugShowCheckedModeBanner: false
    );
  }
}