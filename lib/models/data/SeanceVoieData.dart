import 'package:flutter_uqam/database_helper.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:sqflite/sqflite.dart';

class SeanceVoieData {
  static final String seance_voieTable = "seance_voie";

  static final String colonneFkVoieId = "id_voie";
  static final String colonneFkSeanceId = "id_seance";

  static DatabaseHelper databaseHelper = DatabaseHelper();
  static Database db;

  static final String createTableScript = '''
    CREATE TABLE $seance_voieTable(
        $colonneFkVoieId       Integer NOT NULL,
        $colonneFkSeanceId     Integer NOT NULL
  );''';

  static Future<List<Map<String, dynamic>>> getSeanceVoieMapList(
      int seanceId) async {
    db = await databaseHelper.database;
    String query =
        """SELECT ${VoieData.colonnePkId}, ${VoieData.colonneCouleur}, ${VoieData.colonneEtat}, ${VoieData.colonneCommentaire}, ${VoieData.colonneNom}, ${VoieData.colonneNbPrise}, ${VoieData.colonneFkDifficulte}, ${VoieData.colonneFkTypeValidation}
         FROM Voie JOIN $seance_voieTable ON ${VoieData.voieTable}.id == $seance_voieTable.$colonneFkVoieId WHERE $colonneFkSeanceId = $seanceId""";
    List<Map<String, dynamic>> result = await db.rawQuery(query);

    return result;
  }

  static Future<int> getCount(int seanceId) async {
    db = await databaseHelper.database;
    List<Map<String, dynamic>> x = await db.rawQuery(
        'SELECT COUNT (*) from $seance_voieTable WHERE $colonneFkSeanceId = $seanceId');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Voie List' [ List<Voie> ]
  static Future<List<Voie>> getSeanceVoieList(int seanceId) async {
    var voieMapList = await getSeanceVoieMapList(seanceId);
    int count = voieMapList.length;

    List<Voie> voieList = List<Voie>();
    for (int i = 0; i < count; i++) {
      voieList.add(Voie.fromMapObject(voieMapList[i]));
    }
    return voieList;
  }

  static Future<int> insertSeanceVoie(int seanceId, int voieId) async {
    db = await databaseHelper.database;
    var map = Map<String, dynamic>();
    if (seanceId != null && voieId != null) {
      map[colonneFkVoieId] = voieId;
      map[colonneFkSeanceId] = seanceId;
    }
    var result = await db.insert(seance_voieTable, map);
    return result;
  }

  static Future<int> deleteVoieById(int voieId) async {
    db = await databaseHelper.database;
    int result = await db
        .delete(seance_voieTable, where: '$colonneFkVoieId = ?', whereArgs: [voieId]);
    return result;
  }

  static Future<int> deleteSeanceVoies(int seanceId) async {
    db = await databaseHelper.database;
    int result = await db
        .delete(seance_voieTable, where: '$colonneFkSeanceId = ?', whereArgs: [seanceId]);
    return result;
  }
}
