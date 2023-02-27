import 'package:flutter/material.dart';
import 'package:geolocation/Resources/Views/App.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocalización',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App('Geolocalización'),
      debugShowCheckedModeBanner: false
    );
  }
}