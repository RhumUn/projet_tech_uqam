import 'package:flutter_uqam/models/data/SeanceData.dart';

class Seance {
  int _id;
  String _nom;
  DateTime _date;
  DateTime _heureDebut;
  DateTime _heureFin;
  String _lieu;
  String _commentaire;

  Seance();

  Seance.withPlace(this._lieu);

  Seance.withId(this._id, this._lieu);

  Seance.fromMapObject(Map<String, dynamic> map) {
    this._id = map[SeanceData.colonnePkId];
    this._nom = map[SeanceData.colonneNom];
    this._date = DateTime.tryParse(map[SeanceData.colonneDate]);
    this._heureDebut = DateTime.tryParse(map[SeanceData.colonneHeureDebut]);
    this._heureFin = DateTime.tryParse(map[SeanceData.colonneHeureFin]);
    this._lieu = map[SeanceData.colonneLieu];
    this._commentaire = map[SeanceData.colonneCommentaire];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this._id != null) {
      map[SeanceData.colonnePkId] = this._id;
    }
    map[SeanceData.colonneNom] = this._nom;
    map[SeanceData.colonneDate] = this._date.toString();
    map[SeanceData.colonneHeureDebut] = "${this._heureDebut.hour}:${this._heureDebut.hour}";
    map[SeanceData.colonneHeureFin] = "${this._heureFin.hour}:${this._heureFin.hour}";
    map[SeanceData.colonneLieu] = this._lieu;
    map[SeanceData.colonneCommentaire] = this._commentaire;

    return map;
  }

  String get lieu => _lieu;

  set lieu(String value) {
    _lieu = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get commentaire => _commentaire;

  set commentaire(String value) {
    _commentaire = value;
  }

  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }

  DateTime get heureDebut => _heureDebut;

  set heureDebut(DateTime value) {
    _heureDebut = value;
  }
  DateTime get heureFin => _heureFin;

  set heureFin(DateTime value) {
    _heureFin = value;
  }

}
