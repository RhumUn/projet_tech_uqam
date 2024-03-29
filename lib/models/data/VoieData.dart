import "package:flutter_uqam/models/bussiness/Voie.dart";
import 'package:flutter_uqam/database_helper.dart';
import 'package:flutter_uqam/models/data/DifficulteData.dart';
import 'package:flutter_uqam/models/data/TypeValidationData.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:sqflite/sqflite.dart';

class VoieData {
  static final String voieTable = "Voie";

  static final String colonnePkId = "id";
  static final String colonneNbPrise = "nombre_prise";
  static final String colonneEtat = "etat";
  static final String colonneVideo = "video";
  static final String colonneCouleur = "couleur";
  static final String colonneCommentaire = "commentaire";
  static final String colonneNbEssais = "nombre_essais";
  static final String colonneImage = "image";
  static final String colonneNom = "nom";
  static final String colonneFkTypeValidation = "id_TypeValidation";
  static final String colonneFkDifficulte = "id_Difficulte";
  static final String colonneFkVoieParent = "id_Voie";

  static DatabaseHelper databaseHelper = DatabaseHelper();
  static Database db;

  static final String createTableScript = '''
    CREATE TABLE $voieTable(
        $colonnePkId              Integer  PRIMARY KEY Autoincrement  NOT NULL,
        $colonneNbPrise           Integer,
        $colonneNbEssais          Integer,
        $colonneEtat              Bool NOT NULL ,
        $colonneVideo             Varchar (150),
        $colonneCouleur           Varchar (50),
        $colonneNom               Varchar (50),
        $colonneCommentaire       Text,
        $colonneImage             Varchar (150),
        $colonneFkTypeValidation  Varchar (50) NOT NULL,
        $colonneFkDifficulte      Varchar (50) NOT NULL,
        $colonneFkVoieParent      Integer,
        FOREIGN KEY($colonneFkTypeValidation) REFERENCES ${TypeValidationData
      .typeValidationTable}(${TypeValidationData.colonnePkId}),
        FOREIGN KEY($colonneFkDifficulte) REFERENCES ${DifficulteData
      .difficulteTable}(${DifficulteData.colonnePkId})
  );''';

  static Future<List<Map<String, dynamic>>> getVoieMapList() async {
    db = await databaseHelper.database;
    var result = await db.query(voieTable);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getVoieMapListOrderByDate() async {
    db = await databaseHelper.database;
    var result = await db.query(voieTable, orderBy: "$colonnePkId DESC");
    return result;
  }

  static Future<Voie> getVoieById(int id) async {
    db = await databaseHelper.database;
    var result = await db.query(
        voieTable, where: '$colonnePkId = ?', whereArgs: [id]);
    Voie voie = Voie.fromMapObject(result.first);
    return voie;
  }

  static Future<int> insertVoie(Voie voie) async {
    db = await databaseHelper.database;
    var result = await db.insert(voieTable, voie.toMap());
    return result;
  }

  static Future<int> updateVoie(Voie voie) async {
    db = await databaseHelper.database;
    var result = await db.update(voieTable, voie.toMap(),
        where: '$colonnePkId = ?', whereArgs: [voie.id]);
    return result;
  }

  static Future<int> deleteVoieById(int id) async {
    db = await databaseHelper.database;
    int result =
    await db.delete(voieTable, where: '$colonnePkId = ?', whereArgs: [id]);
    return result;
  }

  static Future<int> getCount() async {
    db = await databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $voieTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Voie List' [ List<Voie> ]
  static Future<List<Voie>> getVoieList() async {
    var voieMapList = await getVoieMapListOrderByDate();
    int count = voieMapList.length;

    List<Voie> voieList = List<Voie>();
    for (int i = 0; i < count; i++) {
      voieList.add(Voie.fromMapObject(voieMapList[i]));
    }

    return voieList;
  }

  static Future<int> getLastItemId() async {
    db = await databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT MAX(id) FROM $voieTable');
    int lastId = Sqflite.firstIntValue(x);

    return lastId;
  }

  static Future<int> getCountVoiesByEtat(bool etat) async {
    db = await databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT count(id) FROM $voieTable WHERE etat == ${Tools.boolToInt(etat)}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  static Future<String> getDifficulteMax() async {
    db = await databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT max($colonneFkDifficulte) As Max FROM $voieTable');
    String result = x[0]["Max"];

    return result;
  }

  static Future<int> getEssaisMax() async {
    db = await databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT max($colonneNbEssais) FROM $voieTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getVoiesParDifficulte() async {
    db = await databaseHelper.database;
    List<String> columnsToSelect = [
      colonneFkDifficulte,
      "count($colonnePkId)"
    ];
    var result = await db.query(voieTable, columns: columnsToSelect, groupBy: colonnePkId);
    return result;
  }
}
