import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/main.dart';
import 'package:frontend/view/widgets/favorite_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/product.dart';
import '../pages/initial_page.dart';



class ProductsCard extends StatefulWidget {
  final List<Product> products;
  final List<dynamic> favorites;
  Function ? changeFavorites;


  ProductsCard({super.key, required this.products, required this.favorites, this.changeFavorites});

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  List<Widget> cards = [];

  @override
  void initState() {
    // int nextRow = 0;
    List<Product> list = widget.products;
    Widget ?previousCard;
    bool isFavorite = false;


    for (var product in list) {
      if(widget.favorites.contains(product.id)){
        isFavorite = true;
      }

      if(previousCard == null){
        previousCard = productCard(product: product,favoriteList: widget.favorites, favorite: isFavorite, changeFavorites: widget.changeFavorites);
        
        if(list.lastIndexOf(product) == list.length-1){
          cards.add(Row( 
            children: [previousCard, productCard(product: product, nombre: "",favoriteList: widget.favorites, favorite: isFavorite, changeFavorites: widget.changeFavorites)]
            )
          );

          isFavorite = false;
          continue;
        }
        isFavorite = false;
        continue;
      }
      
      cards.add(Row( children: [previousCard, productCard(product: product, favoriteList: widget.favorites, favorite: isFavorite, changeFavorites: widget.changeFavorites)]));
      previousCard = null;
      isFavorite = false;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    // print("Route: ${Get.currentRoute}");

    return Container(
      // padding: EdgeInsets.symmetric(),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,

        children: 
        cards,
      )
    );
  }
}

Widget productCard({required Product product, String nombre ="dsa", bool favorite = false, favoriteList, changeFavorites}){

  if(nombre != ''){
    return Expanded(
      flex: 6,
      
      // width:  anchoApp*0.47,
      // widthFactor: 0.4,
      child: SizedBox( height: 355, child: Card(
        
        color: const Color(0xff344E41),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        child: Column(

          children: [
            Stack(
              children: [
                Image.asset(product.image, width: 200,),
                const SizedBox(height: 10,),
                FavoriteButton(product: product, isFavorite: favorite, favoriteList: favoriteList, changeFavorites: changeFavorites)            
              ]
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: 
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(product.name, style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xffffffff)),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(product.brand, style:  GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xffffffff)),),
                        const Spacer(),
                        Text(product.rate, style: GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xffffffff)),),
                        const Icon(Icons.star, color: Colors.white, size: 20,),
                      ],
                    )
                  ]
                )
            )
            // Text(nombre),
          ],
        ),
      ),
    ));
  }

  return  const Expanded( flex: 6, child: Text(""),);
}
