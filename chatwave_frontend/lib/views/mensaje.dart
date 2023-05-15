import 'package:flutter/material.dart';
import 'register.dart';
import '../global.dart';
import '../controller/controller.dart';

class Mensaje extends StatelessWidget {
  Mensaje({super.key});
  final TextEditingController asunto = TextEditingController();
  final TextEditingController mensaje = TextEditingController();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final Controller _controller = Controller();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Boton(
        onPress: () {
          if (_keyForm.currentState!.validate()) {
            _keyForm.currentState!.save();
            _controller
                .sendMessage(email, asunto.text, mensaje.text)
                .then((value) => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text("Resultado"),
                          content: Text(value),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('home'));
                                },
                                child: const Text("OK"))
                          ],
                        ))
            );
          }
        },
        text: "Enviar",
      ),
      body: ListView(
        children: [
          Form(
              key: _keyForm,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          email,
                          style: titulo2,
                          textAlign: TextAlign.center
                        )),
                  ),
                  MensajeCampo(
                      controller: asunto,
                      hintText: 'Asunto',
                      style: tituloContacto),
                  MensajeCampo(
                      controller: mensaje,
                      hintText:
                          'Mensaje',
                      style: fieldTexto),
                ],
              )),
        ],
      ),
    );
  }
}

class MensajeCampo extends StatelessWidget {
  const MensajeCampo({
    super.key,
    required this.controller,
    required this.hintText,
    required this.style,
    this.multiline,
  });

  final TextEditingController controller;
  final String hintText;
  final TextStyle style;
  final bool? multiline;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: style,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      maxLines: null,
      style: style,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Campo obligatorio";
        }
        return null;
      },
    );
  }
}
