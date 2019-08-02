import "package:flutter_uqam/models/bussiness/Seance.dart";
import 'package:flutter_uqam/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SeanceData {
  static final String seanceTable = "Seance";

  static final String colonnePkId = "id";
  static final String colonneNom = "nom";
  static final String colonneDate = "date";
  static final String colonneHeureDebut = "heureDebut";
  static final String colonneHeureFin = "heureFin";
  static final String colonneCommentaire = "commentaire";
  static final String colonneLieu = "lieu";

  static DatabaseHelper databaseHelper = DatabaseHelper();
  static Database db;

  static final String createTableScript =
  '''
  CREATE TABLE $seanceTable(
        $colonnePkId          Integer  PRIMARY KEY Autoincrement  NOT NULL,
        $colonneNom           Varchar (50),
        $colonneDate          Text NOT NULL,
        $colonneHeureDebut    Text,
        $colonneHeureFin      Text,
        $colonneCommentaire   Text,
        $colonneLieu          Varchar (50)
  );''';

  static Future<List<Map<String, dynamic>>> getSeanceMapList() async {
    db = await databaseHelper.database;
    var result = await db.query(seanceTable);
    return result;
  }

  static Future<int> insertSeance(Seance seance) async {
    db = await databaseHelper.database;
    var result = await db.insert(seanceTable, seance.toMap());
    return result;
  }

  static Future<int> updateSeance(Seance seance) async {
    db = await databaseHelper.database;
    var result = await db.update(seanceTable, seance.toMap(), where: '$colonnePkId = ?', whereArgs: [seance.id]);
    return result;
  }

  static Future<int> deleteSeanceById(int id) async {
    db = await databaseHelper.database;
    int result = await db.delete(seanceTable, where: '$colonnePkId = ?', whereArgs: [id]);
    return result;
  }

  static Future<int> getCount() async {
    db = await databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $seanceTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Seance List' [ List<Seance> ]
  static Future<List<Seance>> getSeanceList() async {
    db = await databaseHelper.database;
    var seanceMapList = await getSeanceMapList();
    int count = seanceMapList.length;

    List<Seance> seanceList = List<Seance>();
    for (int i = 0; i < count; i++) {
      seanceList.add(Seance.fromMapObject(seanceMapList[i]));
    }

    return seanceList;
  }
}
