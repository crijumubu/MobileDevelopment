import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Student.dart';

class Card extends StatelessWidget{

  Student student;

  Card(this.student, {super.key});

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        Container(

          margin: const EdgeInsets.only(right: 5, left: 5, bottom: 7),
          child: Column(

            children: [
              CircleAvatar(
                  backgroundImage: AssetImage(student.getImage),
                  radius: 45
              ) //Icon(Icons.account_circle_sharp, size: 90, color: Colors.black)
            ],
          ),
        ),

        Container(

          margin: const EdgeInsets.only(right: 2.5, left: 12.5, bottom: 7),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Text(student.getName, style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black), textAlign: TextAlign.left),
                ],
              ),

              Row(
                children: [
                  Text(student.getDegree, style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black), textAlign: TextAlign.left), //fontStyle: FontStyle.italic,)
                ],
              ),

              Row(
                children: [
                  Text(student.getGrade.toString(), style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)), //fontStyle: FontStyle.italic,)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

}