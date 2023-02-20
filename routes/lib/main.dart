import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routes/Resources/Views/Init.dart';
import 'package:routes/Resources/Views/Menu.dart';

void main() {

  runApp(

      // Opcion 1 y 2
      const MyApp()

      // Opcion 3 (GetMaterialApp)
      /*const GetMaterialApp(
        home: Init(),
      ),*/
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final MaterialColor mainAppColor = const MaterialColor(0xFF14213d, <int, Color>{
    50: Color(0xFF14213d),
    100: Color(0xFF14213d),
    200: Color(0xFF14213d),
    300: Color(0xFF14213d),
    400: Color(0xFF14213d),
    500: Color(0xFF14213d),
    600: Color(0xFF14213d),
    700: Color(0xFF14213d),
    800: Color(0xFF14213d),
    900: Color(0xFF14213d),
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Route pages',
      theme: ThemeData(primarySwatch: mainAppColor),

      initialRoute: '/',
      routes: {

        '/Init': (context) => const Init(),
        '/Menu': (context) => const Menu(),
      },

      home: const Init(),
      debugShowCheckedModeBanner: false
    );
  }
}
