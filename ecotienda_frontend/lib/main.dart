import 'package:flutter/material.dart';
import 'package:frontend/controller/auth_controller.dart';
import 'package:frontend/routes/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';

bool initialRoute = false;
final AuthController authController = AuthController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authController.checkSession().then(
    (value){
        initialRoute = value;
        runApp(const MyApp());
      }
    ); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // primarySwatch: Color(0xff344E41),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff344E41),
        ),
        textTheme: GoogleFonts.rubikTextTheme()
      ),
      initialRoute: initialRoute ? "home-supervisor" : "login-register",
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,

    );
  }
}

