import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Login',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login'),
      debugShowCheckedModeBanner: false
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose(){

    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.title, style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(

        children: [

          Column(

              children: [

                Center(

                    child: Padding(

                      padding: const EdgeInsets.only(top: 100, right: 30, left: 30),
                      child: Image.asset("lib/Assets/flutter.png", width: 225),
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
                                return 'Please enter your username';
                              }
                              else if (!value.contains('@') || !value.contains('.')){
                                return 'Please enter a valid email';
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
                            decoration: const InputDecoration(hintText: 'Password', suffixIcon: Icon(Icons.lock_outline)),

                            validator: (password) {

                              if (password == null || password.isEmpty) {
                                return 'Please enter your password';
                              }

                              return null;
                            },
                          ),
                        ),

                        Padding(

                          padding: const EdgeInsets.only(top: 60,right: 30, left: 30),
                          child: ElevatedButton(

                            onPressed: () {

                              if (_formKey.currentState!.validate()) {

                                print("El usuario es: ${_email.text}\n");
                                print("La contraseña es: ${_password.text}\n");
                              }
                            },

                            child: Text("Sign in", style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white)),
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
