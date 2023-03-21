
import 'package:frontend/controller/auth_controller.dart';
import 'package:frontend/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  AuthController _authController = AuthController();
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future <Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "products.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      
    );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY,
        image TEXT,
        name TEXT,
        brand TEXT,
        rate TEXT
      )

    ''');
  }

  Future <List<Product>> getProductsFavorites() async{
    Database db = await instance.database;
    var favorites = await db.query("products", orderBy: "name");
    List<Product> favoriteList = favorites.isNotEmpty ? favorites.map((e) => Product.fromMap(e)).toList() : [];
    print("lista:$favoriteList");
    
    return favoriteList;
  }

  Future postProductsFavorites() async{
    List<Product> products = [];
    await getProductsFavorites().then((value) => products = value);
    
    
    if(products.isNotEmpty){
      List<dynamic> id = [];
      for (var element in products) {
        id.add(element.id);
      }

      Map<String, dynamic> favoriteList = {"products":id};
      // print(favoriteList);
      int response = 0;
      await _authController.postFavorites(favoriteList).then((value) => response = value);

      return Future.value(response);
    }else{

      await _authController.postFavorites({"products":[]});
    }
    
    
  }

  Future addProducts(List<dynamic> prod) async{
    List<Product> productList = [];
    for (var element in prod) {
      print(element);
      // print(Product.fromMap(element));
      productList.add(Product.fromMap(element[0]));
    }

    for (var i = 0; i < productList.length; i++) {
      add(productList[i]);
    }
  }

  Future add(Product product)async{
    Database db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future remove(Product product)async{
    Database db = await instance.database;
    return await db.delete('products', where: 'id=?', whereArgs: [product.id]);
  }

  Future deleteData() async{
    Database db = await instance.database;
    return await db.rawQuery("DELETE FROM products");

  }

}