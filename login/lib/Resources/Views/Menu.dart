import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/Resources/Views/App.dart';
import '../Controllers/Auth_controller.dart';

class Menu extends StatelessWidget{

  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          automaticallyImplyLeading: false,
          title: Text('Bienvenido', style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)),
          centerTitle: true,
        ),
        body: Column(

            children: [

              Padding(

                  padding: const EdgeInsets.only(top:120, right: 20, left: 20),
                child: Text('¡Bienvenido a nuestra aplicación móvil para estudiantes! Te ayudaremos a mejorar tus habilidades de estudio y a simplificar tu vida académica. Organiza tus horarios, conecta con tus compañeros de clase y accede a materiales de aprendizaje útiles. ¡Estamos aquí para ayudarte! ¡Que tengas un gran éxito académico!', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xFF000000)), textAlign: TextAlign.justify)
              ),

              Padding(

                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(

                    onPressed: () async {

                      await authController.removeToken();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const App(title: 'Iniciar sesión',)));
                    },
                    child: Text('Cerrar Sesión', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white))
                ),
              ),
            ],
        ),
    );
  }
}