import 'package:sqflite/sqflite.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/models/data/SeanceData.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "DataBaseLocal.db";
  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  // make this a singleton class
  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _databaseName;

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 6, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return notesDatabase;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(VoieData.createTableScript);
    await db.execute(SeanceData.createTableScript);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE seance DROP COLUMN ${SeanceData.colonneHeureDebut}");
      db.execute("ALTER TABLE seance ADD COLUMN ${SeanceData.colonneHeureDebut} Text NOT NULL");
    }
  }
}