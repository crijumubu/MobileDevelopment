import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget{

  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          centerTitle: true,
          title: Text('Vistas navegables', style: GoogleFonts.openSans(fontSize: 21, fontWeight: FontWeight.w700, color: Colors.white)),
        ),

        body: Container(

          color: const Color(0XFFe5e5e5),
          width: MediaQuery.of(context).size.width,

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              SizedBox(

                  width: 300,
                  height: 300,
                  child: Image.network('https://assets.stickpng.com/thumbs/58aff1e7829958a978a4a6ce.png', fit:BoxFit.fill)
              ),
            ],
          )
        )
    );
  }
}
