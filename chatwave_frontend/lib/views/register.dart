import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../global.dart';

import '../controller/controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Controller _controller = Controller();

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final TextEditingController nombres = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController contrasena = TextEditingController();
  final TextEditingController telefono = TextEditingController();
  final TextEditingController cargo = TextEditingController();

  File? imagen;
  XFile? imgBytes;

  @override
  void initState() {
    super.initState();
  }

  void galeria() async {
    XFile? img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (img != null) {
      setState(() {
        imagen = File(img.path);
      });

      imgBytes = img;
    }
  }

  void camara() async {
    XFile? img = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (img != null) {
      setState(() {
        imagen = File(img.path);
      });

      imgBytes = img;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro", style: appbar,),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
              key: _keyForm,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 233, 233, 233),
                        radius: 80,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              const Color.fromARGB(255, 209, 209, 209),
                          backgroundImage: (imagen == null)
                              ? const AssetImage("assets/images/user.png")
                              : (FileImage(imagen!) as ImageProvider),
                        )
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              galeria();
                            },
                            child: Text("Galeria", style: botonTexto)),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              camara();
                            },
                            child: Text("Camara", style: botonTexto))
                      ],
                    ),
                    CampoTexto(
                        controller: nombres,
                        ocultar: false,
                        text: 'Nombre',
                        hint: "Ej: Mark Zuckerberg",
                        tipoInput: "texto"),
                    CampoTexto(
                        controller: email,
                        ocultar: false,
                        text: 'Email',
                        hint: "Ej: mark_zuckerberg@meta.com",
                        tipoInput: "email"),
                    CampoTexto(
                        controller: telefono,
                        ocultar: false,
                        text: 'Telefono',
                        hint: "Ej: +1 31771312014",
                        tipoInput: "numero"),
                    CampoTexto(
                        controller: cargo,
                        ocultar: false,
                        text: 'Cargo',
                        hint: "Ej: CEO",
                        tipoInput: "texto"),
                    CampoTexto(
                      controller: contrasena,
                      ocultar: true,
                      text: 'Contraseña',
                      hint: "",
                      tipoInput: "contrasena",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Boton(
                      text: "Registrarme",
                      onPress: () {
                        if (_keyForm.currentState!.validate()) {
                          _keyForm.currentState!.save();
                          if (imgBytes != null) {
                            _controller
                                .register(
                                    context,
                                    nombres.text,
                                    email.text,
                                    contrasena.text,
                                    telefono.text,
                                    cargo.text,
                                    imgBytes!)
                                .then((value) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => value);
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "Por favor seleccione una foto de perfil."),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, "OK"),
                                            child: const Text("OK"))
                                      ],
                                    ));
                          }
                        }
                      },
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class Boton extends StatelessWidget {
  const Boton({
    super.key,
    required this.onPress,
    required this.text,
  });

  final Function onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          onPressed: () {
            onPress();
          },
          child: Text(
            text,
            style: botonTexto,
          )),
    );
  }
}

class CampoTexto extends StatelessWidget {
  const CampoTexto({
    super.key,
    required this.controller,
    required this.text,
    required this.ocultar,
    required this.hint,
    required this.tipoInput,
  });

  final TextEditingController controller;
  final bool ocultar; // * Para contraseñas
  final String text; // * Texto encima
  final String hint; // * Texto ejemplo
  final String tipoInput; // ? texto / numero / email / contrasena

  @override
  Widget build(BuildContext context) {
    TextInputType teclado;
    switch (tipoInput) {
      case "email":
        teclado = TextInputType.emailAddress;
        break;
      case "numero":
        teclado = TextInputType.number;
        break;
      case "contrasena":
        teclado = TextInputType.visiblePassword;
        break;
      default:
        teclado = TextInputType.name;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Text(
                text,
                style: subTitulo,
              )),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: controller,
            obscureText: ocultar,
            keyboardType: teclado,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                isDense: true,
                hintText: hint),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Campo obligatorio";
              }
              switch (tipoInput) {
                case "texto": // ? Validacion de solo texto
                  if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Por favor ingresar unicamente caracteres de texto.";
                  }
                  break;

                case 'number': // ? Validacion de solo numeros
                  if (!RegExp(
                          r'^(\+\d{1,2}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$')
                      .hasMatch(value)) {
                    return "Por favor ingresar unicamente caracteres numericos.";
                  }
                  break;

                case 'email': // ? Validacion de email
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                      .hasMatch(value)) {
                    return "Por favor ingresar un correo valido.";
                  }
                  break;

                default:
                  return null;
              }

              return null;
            },
            style: fieldTexto,
          ),
        ],
      ),
    );
  }
}
