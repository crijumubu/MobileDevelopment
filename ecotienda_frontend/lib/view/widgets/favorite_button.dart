import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../model/database.dart';
import '../../model/product.dart';

class FavoriteButton extends StatefulWidget {
  final Product product;
  final bool isFavorite;
  final List<dynamic> favoriteList;
  dynamic changeFavorites;

  FavoriteButton({super.key, required this.product, required this.isFavorite, required this.favoriteList, this.changeFavorites});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _pressed = false;
  @override
  void initState() {
    _pressed = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: 
      IconButton(onPressed: () async {
        setState(()  {
          _pressed = !_pressed;
        });

        if(_pressed){
          widget.favoriteList.add(widget.product.id);
          await DatabaseHelper.instance.add(widget.product);
        }else{
          if(widget.favoriteList.length==1){
            widget.favoriteList.clear();
          }
          do {
            widget.favoriteList.remove(widget.product.id);
          } while (widget.favoriteList.contains(widget.product));
          await DatabaseHelper.instance.remove(widget.product);
        }

        if(widget.changeFavorites != null){
          widget.changeFavorites(widget.favoriteList);
        }

        
      }, 
      icon: Icon((_pressed==false ? Icons.favorite_border : Icons.favorite)), color: const Color(0xff344E41), iconSize: 30,)
    );
  }
}