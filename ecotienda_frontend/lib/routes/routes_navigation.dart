import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/view/pages/favorites.dart';
import 'package:frontend/view/widgets/navigation.dart';

import '../model/database.dart';
import '../model/product.dart';
import '../view/pages/products_view.dart';
import '../view/pages/user.dart';

class RoutesNavigation extends StatefulWidget {
  final int index;
  final String name;
  final List<dynamic> list;

  const RoutesNavigation({super.key, required this.index, required this.name, required this.list});

  @override
  State<RoutesNavigation> createState() => _RoutesNavigationState();
}

class _RoutesNavigationState extends State<RoutesNavigation> {
  late List<dynamic> localFavorites = [];
  List<Product> productosQuery = [];    
  final List<Product> _productList = [];

  void toProductList(){
    for (var element in widget.list) {
      _productList.add(Product.fromMap(element));
    }
  }

  @override
  void initState() {
    DatabaseHelper.instance.getProductsFavorites().then((value) => setState(() {
      productosQuery = value;
    }),);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var product in productosQuery) {
      localFavorites.add(product.id);
    }

    toProductList();
    List<Widget> pages =  [
      User(name: widget.name,),
      Products(lista: _productList, favoritosLocal: localFavorites,),
      Favorites(favoritosLocal: localFavorites),
    ];

    return pages[widget.index];
  }
}
