import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modals/Resources/Views/Option.dart';

class App extends StatefulWidget{

  final String title;
  const App({super.key, required this.title});

  @override
  State<App> createState() => _AppState(title);
}

enum colors { amarillo, azul, rojo, verde, naranja }

class _AppState extends State<App>{

  String title;

  _AppState(this.title);

  colors? _colors = colors.amarillo;

  String radioOption = '';

  void update(String color){

    String option = '';

    switch(color){

      case 'colors.amarillo':
        option = 'Amarillo';
        break;

      case 'colors.azul':
        option = 'Azul';
        break;

      case 'colors.rojo':
        option = 'Rojo';
        break;

      case 'colors.verde':
        option = 'Verde';
        break;

      case 'colors.naranja':
        option = 'Naranja';
        break;
    }

    setState(() {
      radioOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text(title, style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)), centerTitle: true,),
      body: Container(

        color: Color(0xFFedf2f4),

        child: Center(

          child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Container(

                  width: 250,

                  child: Padding(

                    padding: const EdgeInsets.only( bottom: 30.0),
                    child: ElevatedButton(

                      child: Text('Mostrar opciones (1)', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white)),
                      onPressed: () {

                        showModalBottomSheet<void>(

                          context: context,
                          builder: (BuildContext context) {

                            return Expanded(

                                  child: Container(

                                      color: Color(0xFFedf2f4),
                                      height: 300,

                                      child: Column(

                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,

                                          children: <Widget>[

                                            Container(

                                              width: 250,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Option(title, 'Lila')));
                                                  },
                                                  child: Text('Botón Lila', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white))
                                              ),
                                            ),

                                            Container(

                                              width: 250,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Option(title, 'Rojo')));
                                                  },
                                                  child: Text('Botón Rojo', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white))
                                              ),
                                            ),

                                            Container(

                                              width: 250,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Option(title, 'Naranja')));
                                                  },
                                                  child: Text('Botón Naranja', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white))
                                              ),
                                            ),

                                            Padding(

                                              padding: const EdgeInsets.only(top: 25),
                                              child: ElevatedButton(

                                                child: Text('Cerrar', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white)),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ),
                                          ]
                                      )
                                  )
                              );
                          },
                        );
                      },
                    ),
                  ),
                ),

                Container(

                  width: 250,

                  child: Padding(

                    padding: const EdgeInsets.only( top: 30.0),
                    child: ElevatedButton(

                      child: Text('Mostrar opciones (2)', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white)),
                      onPressed: () {

                        showModalBottomSheet<void>(

                            context: context,
                            builder: (BuildContext context) {

                              return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {

                                    return Container(

                                      color: Color(0xFFedf2f4),
                                      height: 400,

                                      child: Column(

                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: <Widget>[

                                          RadioListTile<colors>(
                                            title: const Text('Amarillo'),
                                            value: colors.amarillo,
                                            groupValue: _colors,
                                            onChanged: (colors? value) {
                                              setState(() {
                                                _colors = value;
                                              });
                                            },
                                          ),

                                          RadioListTile<colors>(
                                            title: const Text('Azul'),
                                            value: colors.azul,
                                            groupValue: _colors,
                                            onChanged: (colors? value) {
                                              setState(() {
                                                _colors = value;
                                              });
                                            },
                                          ),

                                          RadioListTile<colors>(
                                            title: const Text('Rojo'),
                                            value: colors.rojo,
                                            groupValue: _colors,
                                            onChanged: (colors? value) {
                                              setState(() {
                                                _colors = value;
                                              });
                                            },
                                          ),

                                          RadioListTile<colors>(
                                            title: const Text('Verde'),
                                            value: colors.verde,
                                            groupValue: _colors,
                                            onChanged: (colors? value) {
                                              setState(() {
                                                _colors = value;
                                              });
                                            },
                                          ),

                                          RadioListTile<colors>(
                                            title: const Text('Naranja'),
                                            value: colors.naranja,
                                            groupValue: _colors,
                                            onChanged: (colors? value) {
                                              setState(() {
                                                _colors = value;
                                              });
                                            },
                                          ),

                                          Padding(

                                            padding: const EdgeInsets.only( top: 15.0),
                                            child: ElevatedButton(

                                              child: Text('Aceptar', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white)),
                                                onPressed: (){

                                                  update(_colors.toString());
                                                  Navigator.pop(context);
                                                },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                );
                            }
                        );
                      }
                    ),
                  )
                ),

                Text('Botón presionado', style: GoogleFonts.openSans(fontSize: 19, fontWeight: FontWeight.w500, color: Colors.black)),
                Text(radioOption, style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
