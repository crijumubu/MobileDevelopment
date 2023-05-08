import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_images/Resources/Views/Send.dart';

class App extends StatefulWidget{

  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App>{

  File? image;

  Future pickImage(int source) async{
    try{

      final image;

      if (source == 0){

        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      }else{

        image = await ImagePicker().pickImage(source: ImageSource.camera);
      }

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {

      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

        appBar: AppBar(

          automaticallyImplyLeading: false,
          title: Text('Vista opciones', style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)),
          centerTitle: true,
        ),
        body: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Padding(

                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: Text('Compartir\nimagen desde:', style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w500, color: Colors.black), textAlign: TextAlign.center),
              ),
              Padding(

                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(

                    width: 250,
                    height: 40,
                    child: ElevatedButton(onPressed: () async{
                      await pickImage(1);
                      if (image != null){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Send(image: image)));
                      }
                    }, child: Text('Cámara', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)))
                ),
              ),
              Padding(

                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: SizedBox(

                    width: 250,
                    height: 40,
                    child: ElevatedButton(onPressed: () async{
                      await pickImage(0);
                      if (image != null){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Send(image: image)));
                      }
                    }, child: Text('Galería', style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)))
                ),
              )
            ],
          ),
        )
    );
  }
}