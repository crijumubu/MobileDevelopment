import 'package:mongo_dart/mongo_dart.dart';
import 'Credentials.dart';

class Mongo{

  static var database, databaseCollection;

  static connect() async {

    database = await Db.create(mongo);
    await database.open();
    databaseCollection = database.collection(collection);
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    final users = await databaseCollection.find().toList();
    await database.close();
    return users;
  }
}

