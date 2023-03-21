import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/auth_controller.dart';
import 'package:frontend/routes/routes_navigation.dart';
import 'package:frontend/view/widgets/header.dart';
import 'package:frontend/view/widgets/logo.dart';

import '../widgets/navigation.dart';

class HomeSupervisor extends StatefulWidget {
  const HomeSupervisor({super.key});

  @override
  State<HomeSupervisor> createState() => _HomeSupervisorState();
}

class _HomeSupervisorState extends State<HomeSupervisor> {
  final AuthController _authController = AuthController();
  int index = 0;
  List<dynamic> listProduct = [];
  late String name = "";
  Navigation ?navigation;

  @override
  void initState() {
    _authController.getProducts(context).then((value) => setState(() {
      listProduct = value ;
    },));
    _authController.getUsername().then((value) => setState(() {
      name = value;
    },));



    navigation = Navigation(currentIndex: (i){
      setState(() {
        index = i;
      });
    });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: navigation,
      
      body: WillPopScope(
        onWillPop: () async => false,
        child: ListView(
          children: [
            const Header(),
            RoutesNavigation(index: index, name: name, list: listProduct)
          ],
        ),
      ),
    );
  }
}