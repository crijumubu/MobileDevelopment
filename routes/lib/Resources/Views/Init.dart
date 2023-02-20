import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routes/Resources/Views/Menu.dart';
import 'package:get/get.dart';

class Init extends StatefulWidget{

  const Init({super.key});

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init>{

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

            children: [

              Padding(

                padding: const EdgeInsets.only(top: 105, bottom: 50),
                child: SizedBox(

                    width: 150,
                    height: 50,
                    child: ElevatedButton(

                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Menu()));
                        },
                        style: ElevatedButton.styleFrom(primary: const Color(0xFFfca311)),
                        child: Text("Metodo 1", style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white))
                    )
                ),
              ),

              Padding(

                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: SizedBox(

                    width: 150,
                    height: 50,
                    child: ElevatedButton(

                        onPressed: (){
                          Navigator.pushNamed(context, '/Menu');
                        },
                        style: ElevatedButton.styleFrom(primary: const Color(0xFFfca311)),
                        child: Text("Metodo 2", style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white))
                    )
                ),
              ),

              Padding(

                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: SizedBox(

                    width: 150,
                    height: 50,
                    child: ElevatedButton(

                        onPressed: (){
                          Get.to(() => const Menu());
                        },
                        style: ElevatedButton.styleFrom(primary: const Color(0xFFfca311)),
                        child: Text("Metodo 3", style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white))
                    )
                ),
              ),
            ],
          ),
        )
    );
  }

  
}