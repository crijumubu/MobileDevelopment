import 'package:flutter/material.dart';
import 'register.dart';
import '../controller/controller.dart';

import '../global.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final keyForm = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController contrasena = TextEditingController();
  final Controller _controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iniciar sesión", style: appbar,),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 70, right: 20),
              child: Form(
                  key: keyForm,
                  child: Column(
                    children: [
                      const CircleAvatar(
                          backgroundColor:
                          Color.fromARGB(255, 233, 233, 233),
                          radius: 80,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor:
                            Color.fromARGB(255, 209, 209, 209),
                            backgroundImage: AssetImage("assets/images/user.png")
                          )
                      ),
                      CampoTexto(
                        controller: email,
                        text: 'Email',
                        hint: '',
                        ocultar: false,
                        tipoInput: 'email',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CampoTexto(
                        controller: contrasena,
                        text: 'Contraseña',
                        hint: '',
                        ocultar: true,
                        tipoInput: 'contrasena',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Boton(
                        text: "Ingresar",
                        onPress: () {
                          // Navigator.pushReplacementNamed(context, "/",);
                          _controller
                              .login(context, email.text, contrasena.text)
                              .then((value) {
                            if (value == null) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "home", (Route route) => false);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text("Resultado"),
                                        content: Text(value),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK"))
                                        ],
                                      ));
                            }
                          });
                        },
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
