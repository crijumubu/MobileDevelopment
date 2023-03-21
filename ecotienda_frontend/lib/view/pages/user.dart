import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/auth_controller.dart';
import 'package:frontend/view/widgets/routing_button.dart';
import 'package:google_fonts/google_fonts.dart';

class User extends StatelessWidget {
  final AuthController _authController = AuthController();
  String name;
  User({super.key, required this.name});

  @override
  Widget build(BuildContext context) {

    return  SizedBox(height: 400 , child: Center(child:
      Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 250,),
            const Icon(
              Icons.person_pin,
              size: 130,
              color: Color(0xff588157),
            ),
            Column( 
              children: [
                Text("Usuario: ${name[0].toUpperCase()}${name.substring(1).toLowerCase()}", style: GoogleFonts.rubik(fontSize: 26, fontWeight: FontWeight.w400)),
                const SizedBox(height: 20,),
                RoutingButton(text: "Cerrar Sesion", route: "login-register", callback: ()async{
                  await _authController.closeSession();
                  // Navigator.pushNamed( context, "login-register");
                  return Future.value(true);
                },)
              ],
            )
            
          ],
       )
      ]
    )));

  }
}