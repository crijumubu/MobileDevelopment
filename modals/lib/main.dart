import 'package:flutter/material.dart';
import 'package:modals/Resources/Utilities/pallete.dart';
import 'package:modals/Resources/Views/App.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Modals application',
        theme: ThemeData(
          primarySwatch: Palette.color,
        ),
        home: const App(title: 'Modals application'),
        debugShowCheckedModeBanner: false
    );
  }
}