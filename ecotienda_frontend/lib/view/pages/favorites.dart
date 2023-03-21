import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend/model/database.dart';
import 'package:frontend/view/pages/products_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/product.dart';

class Favorites extends StatefulWidget {
  final List<dynamic> favoritosLocal;
  const Favorites({super.key, required this.favoritosLocal});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late List<dynamic> favs;
  @override
  void initState() {
    favs = widget.favoritosLocal;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: FutureBuilder <List<Product>>(
        future: DatabaseHelper.instance.getProductsFavorites(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
          if(!snapshot.hasData){
            return Center(child: Container( padding: const EdgeInsets.only(top:200),child: Text("Cargando", style: GoogleFonts.rubik(fontSize: 28, fontWeight: FontWeight.w400),textAlign: TextAlign.center,)));
          }

          print(favs);

          return snapshot.data!.isEmpty ? 
          Center(child: Container( padding: const EdgeInsets.only(top:200),child: Text("No hay productos en favoritos.", style: GoogleFonts.rubik(fontSize: 30, fontWeight: FontWeight.w400),textAlign: TextAlign.center,))) :
          Products(lista: snapshot.data??[], favoritosLocal:favs, changeFavorites: (List<dynamic> newFavs){
            print(newFavs);
            setState(() {
              favs = newFavs;
            });
          } );
        }
      ),
    );
  }
}