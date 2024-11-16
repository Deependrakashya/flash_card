import 'dart:async';

import 'package:flash_card/repository/api_models/flash_card_model/flash_card_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class FlashCardDB {
  static Database? flash_cardDb;
  //check for db that is it created or not
  Future<Database?> get db async {
    if (flash_cardDb != null) {
      print('database exits');
      return flash_cardDb;
    } else {
      // db not exits then create a new db
      flash_cardDb = await initDatabase();
      print('new db create');
      return flash_cardDb;
    }
  }

  initDatabase() async {
    // getting phone directory path to make a db file for store data
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'flash_cardDB');
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute(
        'CREATE TABLE flash_cardDb (id INTEGER PRIMARY KEY AUTOINCREMENT, query TEXT NOT NULL, ans TEXT NOT NULL)');
    print('table create');
  }

  // insert data into created table
  Future<FlashCardModel> insert(FlashCardModel flashCardModel) async {
    var dbClient = await db;
    await dbClient?.insert('flash_cardDb', flashCardModel.toJson());
    print('data inserted into db');
    return flashCardModel;
  }

  // get stored data into local database
  Future<List<FlashCardModel>> getStoredData() async {
    var dbClient = await db;
    var queryResult = await dbClient!.query('flash_cardDb');
    print('getting data $queryResult');
    return queryResult.map((e) => FlashCardModel.fromJson(e)).toList();
  }

  //  deleting a row from database using id
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete('flash_cardDb', where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(FlashCardModel flashCardModel) async {
    var dbClient = await db;
    return dbClient!.update('flash_cardDb', flashCardModel.toJson(),
        where: 'id=?', whereArgs: [flashCardModel.id]);
  }
}
