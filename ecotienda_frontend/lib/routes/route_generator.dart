import 'package:flutter/material.dart';
import 'package:frontend/view/pages/home_supervisor.dart';
import 'package:frontend/view/pages/initial_page.dart';
import 'package:frontend/view/pages/login.dart';
import 'package:frontend/view/pages/register.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name) {
      case "login-register":
        return MaterialPageRoute(builder: (_) => const InitialPage());
        
      case "/login":
        return MaterialPageRoute(builder: (_) => const Login());

      case "/register":
        return MaterialPageRoute(builder: (_) => const Register());

      case "home-supervisor":
        return MaterialPageRoute(builder: (_)=> const HomeSupervisor());

      case "/home-supervisor":
        return MaterialPageRoute(builder: (_)=> const HomeSupervisor());

      default:
        return _errorRoute();
    }
  }


  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("ERROR RUTA", style: TextStyle(fontSize: 32),)
          ],
        ),
      )
      );
    });
  }
}