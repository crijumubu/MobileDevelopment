import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppExceptionContent extends StatelessWidget {

  const AppExceptionContent({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color.fromRGBO(255, 252, 247, 1),

      appBar: AppBar(

        centerTitle: true,
        title: Text('Lista de estudiantes', style: GoogleFonts.openSans(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),

      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(

            padding: const EdgeInsets.only(right: 40, left: 40),
            child: PhysicalModel(

              color: Colors.orange,
              elevation: 15,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.circular(20),

              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Ups, algo ha salido mal al conectar con la base de datos. Por favor, revisa tu conexion a internet y si el problema persiste comunicate con el personal de soporte.', style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.justify),
              ),
            ),
          ),
        ],
      ),
    );
  }
}