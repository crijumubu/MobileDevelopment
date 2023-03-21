import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/view/widgets/favorite_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/product.dart';
import '../pages/initial_page.dart';

class ProductsList extends StatefulWidget {

  final List<Product> products;
  final List<dynamic> favorites;
  dynamic changeFavorites;


  ProductsList({super.key, required this.products, required this.favorites, this.changeFavorites});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Widget> items = [];

    @override
  void initState() {
    List<Product> list = widget.products;
    bool isFavorite = false;

    for (var product in list) {
      if(widget.favorites.contains(product.id)){
        print("${product.id}: ${widget.favorites.contains(product.id)}");
        isFavorite = true;
      }

      items.add(productItem(product: product, favorite: isFavorite, favoriteList: widget.favorites, changeFavorites:widget.changeFavorites));    
      isFavorite = false;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  Column(
      children: items,
    );
  }
}


Widget productItem({required Product product, bool favorite = false, favoriteList, changeFavorites }){

  // print("$nombre :${nombre.length>30}");
  return Container(  
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xff344E41)),
    margin: const EdgeInsets.symmetric(vertical: 5),

    child:   Row(
      children: [
        Column(children: [
          Stack(
            children: [
              Image.asset(product.image, height: 120,),
              FavoriteButton(product: product, isFavorite: favorite, favoriteList: favoriteList, changeFavorites: changeFavorites)
            ],
          )
        ],),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: 
          Column(
          children: [
            
            Text((product.name.length > 26 ? "${product.name.substring(0,26)}..." : product.name), style: GoogleFonts.rubik(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),

            Text(product.brand, style: GoogleFonts.rubik(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
            Row(
              children: [
                Text("Calificación: ${product.rate}", style: GoogleFonts.rubik(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
                const Icon(Icons.star, color: Colors.white,)

              ],
            )
            

          ],
        )
        ),
      ],
    )
  );

}
