import 'package:biometric/Resources/Controller/Auth_controller.dart';
import 'package:biometric/Resources/Views/App.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authorize extends StatelessWidget {

  final String _title = 'Autorización';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          title: Text(_title, style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)), centerTitle: true,),
        body: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(

                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text('¿Sabías que puedes hacer más seguro tu acceso a nuestra aplicación habilitando la función de huella dactilar? Es muy fácil, solo oprime en el siguiente botón para activar esta opción. ¡Te lo recomendamos!', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black), textAlign: TextAlign.justify),
                ),

                Padding(

                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(onPressed: (){

                    AuthController.fingerAuthorization = true;
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const App()));
                  }, child: Text("Habilitar", style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white))),
                )
              ],
            )
        )
    );
  }
}
