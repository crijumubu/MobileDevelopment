import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class Send extends StatelessWidget {

  final File? image;

  const Send({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          title: Text('Vista compartir', style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)), centerTitle: true,),
        body: Center(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(

                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                          height: 300,
                          child: image != null ? Image.file(image!) : Text("No image seleceted"),
                      ),
                    ),

                    Padding(

                      padding: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(

                          width: 250,
                          height: 40,
                          child: ElevatedButton(onPressed: (){
                            Share.shareFiles([image!.path], text: "Compartir con imagenes");
                          }, child: Text('Compartir imagen', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)))
                      ),
                    ),
                  ],
                )
            )
    );
  }
}