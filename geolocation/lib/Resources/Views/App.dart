import 'package:flutter/material.dart';
import 'package:geolocation/Resources/Services/Locator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget{

  String title;

  App(this.title, {super.key});

  @override
  Widget build(BuildContext context) {

    Locator locator = Locator();

    return Scaffold(

      appBar: AppBar(

        title: Text(this.title, style: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(

        child: Padding(

            padding: EdgeInsets.only(right: 50, left: 50),
            child: Text('Usa nuestra aplicación para encontrar tu ubicación exacta y llegar a donde quieres. ¡Empieza a explorar ahora!', textAlign: TextAlign.justify, style: GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.w600))
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {

          String url= '';
          Position? currentLocation = locator.getLocation;

          if (currentLocation != null){
            url += 'http://www.google.com/maps/place/${currentLocation.latitude},${currentLocation.longitude}';
          }

          locator.showMap(url);
        },
        tooltip: 'Obtener ubicación',
        child: const Icon(Icons.location_pin),
      ),
    );
  }
}