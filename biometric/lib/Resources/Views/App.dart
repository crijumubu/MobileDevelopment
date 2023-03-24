import 'package:biometric/Resources/Controller/Auth_controller.dart';
import 'package:biometric/Resources/Views/Authorize.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget{

  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App>{

  final String _title = 'Iniciar sesión';
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _displayAlert(String title, String content) async{

    await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text('Ok'))
            ],
          );
        }
    );
  }

  void clearInputs(){

    _email.text = '';
    _password.text = '';
  }

  @override
  void dispose(){

    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

        appBar: AppBar(

          automaticallyImplyLeading: false,
          title: Text(_title, style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)),
          centerTitle: true,
        ),
        body: ListView(

          children: [

            Column(

              children: [

                Center(

                    child: Padding(

                      padding: const EdgeInsets.only(top: 100, right: 30, left: 30),
                      child: Image.asset("lib/Resources/Assets/flutter.png", width: 225),
                    )
                ),
                Form(

                    key: _formKey,
                    child: Column(

                      children: [

                        Padding(

                          padding: const EdgeInsets.only(top: 50,right: 30, left: 30),
                          child: TextFormField(

                            controller: _email,
                            enableInteractiveSelection: false,
                            decoration: const InputDecoration(hintText: 'Email', suffixIcon: Icon(Icons.account_circle_outlined)),
                            validator: (value) {

                              if (value == null || value.isEmpty) {

                                return 'Por favor, introduzca su correo electrónico';
                              }
                              else if (!value.contains('@') || !value.contains('.')){

                                return 'Introduzca un correo electrónico válido';
                              }

                              return null;
                            },
                          ),
                        ),

                        Padding(

                          padding: const EdgeInsets.only(top: 20,right: 30, left: 30),
                          child: TextFormField(

                            controller: _password,
                            enableInteractiveSelection: false,
                            obscureText: true,
                            decoration: const InputDecoration(hintText: 'Contraseña', suffixIcon: Icon(Icons.lock_outline)),
                            validator: (password) {

                              if (password == null || password.isEmpty) {

                                return 'Por favor, introduzca su contraseña';
                              }

                              return null;
                            },
                          ),
                        ),

                        Padding(

                          padding: const EdgeInsets.only(top: 20,right: 30, left: 30),
                          child: Column(

                            children: [

                              SizedBox(

                                width: double.infinity,
                                height: 40,
                                child: ElevatedButton( onPressed: () async{

                                    if (_formKey.currentState!.validate()) {

                                      bool response = await AuthController.loginUser(_email.text, _password.text);
                                      if (response){

                                        await _displayAlert('Inicio de sesión exitóso', 'Bienvenido al sistema');
                                        clearInputs();
                                        if (!AuthController.fingerAuthorization){

                                          if (!mounted) return;
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Authorize()));
                                        }
                                      }
                                      else{

                                        _displayAlert('Credenciales incorrectas', 'Usuario o contraseña errónea');
                                        clearInputs();
                                      }
                                    }
                                  }, child: Text("Ingresar", style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
                                ),
                              ),

                              AuthController.fingerAuthorization ? Padding(

                                padding: const EdgeInsets.only(top: 30),
                                child: ElevatedButton(onPressed: () async{

                                  if (await AuthController.authenticate()){

                                    _displayAlert('Inicio de sesión exitóso', 'Bienvenido al sistema');
                                    clearInputs();
                                  }
                                }, child: Padding(

                                  padding: const EdgeInsets.all(15),
                                  child: Column(

                                    children: [

                                      const Icon(IconData(0xe287, fontFamily: 'MaterialIcons'), size: 48.0),
                                      Padding(

                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text("Ingresa con\nhuella", style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center),
                                      )
                                    ],
                                  ),
                                )),
                              )
                              : Container(),
                              ],
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ],
        )
    );
  }
}