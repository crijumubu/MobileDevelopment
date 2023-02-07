import 'package:flutter/material.dart';
import './Resources/App.dart' as design;
import './Resources/Student.dart';
import './Resources/Database/Mongo.dart';
import 'Resources/AppException.dart';

List<Student> students = [];

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  try{

    await Mongo.connect();
    var data = await Mongo.getDocuments();
    makeStudents(data);
    runApp(const MyApp());
  }catch (e){

    runApp(const MyAppException());
  }
}

void makeStudents(List data){

  for (int i=0; i<data.length; i++){
    students.add(Student(data[i]['Name'], data[i]['Degree'], double.parse(data[i]['Grade'].toString()), data[i]['Image']));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        title: 'Lista de estudiantes',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: design.App(students),
      debugShowCheckedModeBanner: false
    );
  }
}

class MyAppException extends StatelessWidget{
  const MyAppException({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        title: 'Error de ejecucion de la lista de estudiantes',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const AppExceptionContent(),
        debugShowCheckedModeBanner: false
    );
  }
}