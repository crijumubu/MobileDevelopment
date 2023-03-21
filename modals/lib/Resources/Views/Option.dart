import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Option extends StatelessWidget {
  String title;
  String option;

  Option(this.title, this.option, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          title: Text(title, style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)), centerTitle: true,),
        body: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text('Botón presionado', style: GoogleFonts.openSans(fontSize: 19, fontWeight: FontWeight.w500, color: Colors.black)),
              Text('$option', style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
            ],
          )
        )
    );
  }
}