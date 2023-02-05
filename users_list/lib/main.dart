import 'package:flutter/material.dart';
import 'Body.dart' as design;
import 'Student.dart';

void main() {
  runApp(const MyApp());
}

List<Student> students = [Student('Cristian Munoz', 'Ing. Sistemas', 4.2), Student('Daniela Moreno', 'Psicologia', 5), Student('Santiago Hernandez', 'Ing. Mecanica', 4.5), Student('Lina Celedon', 'Ing. Civil', 4.1), Student('Nicolas Florez', 'Derecho', 3.9), Student('Valeria Bernal', 'Adm. Empresas', 4.0), Student('Sergio Baron', 'Ing. Sistemas', 4.2)];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        title: 'Lista de estudiantes',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: design.Body(students),
      debugShowCheckedModeBanner: false
    );
  }
}