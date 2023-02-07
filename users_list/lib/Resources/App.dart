import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Card.dart' as identification;
import 'Student.dart';

class App extends StatelessWidget{

  List<Student> students;

  App(this.students, {super.key});

  List<Widget> _createChildren(){
    List<Widget> cards = [];

    for (int i=0; i<students.length; i++){
      cards.add(identification.Card(students[i]));
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color.fromRGBO(255, 252, 247, 1),

      appBar: AppBar(

        centerTitle: true,
        title: Text('Lista de estudiantes', style: GoogleFonts.openSans(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        children: _createChildren()
      )
    );
  }
}