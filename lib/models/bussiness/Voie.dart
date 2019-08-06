import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/tools/tools.dart';

class Voie {
  int _id;
  int _nombre_prise;
  bool _etat = false;
  String _video = "";
  String _couleur = "";
  String _commentaire = "";
  int _nombreEssais = 0;

  int get nombreEssais => _nombreEssais;

  set nombreEssais(int value) {
    _nombreEssais = value;
  }

  set nom(String value) {
    _nom = value;
  }

  String _nom = "";
  String _image = "";
  String _typeValidation = "Avec essais";
  String _difficulte = "V0";
  int _parentId;
  int _seanceId;

  Voie();

  Voie.withDifficulty(this._difficulte, this._seanceId) {
    genererNom();
  }

  Voie.withParentId(this._difficulte, this._seanceId, this._parentId) {}

  Voie.withId(this._id, this._difficulte, this._seanceId) {}

  Voie.fromMapObject(Map<String, dynamic> map) {
    this._id = map[VoieData.colonnePkId];
    this._nom = map[VoieData.colonneNom];
    this._nombre_prise = map[VoieData.colonneNbPrise];
    this._etat = Tools.intToBool(map[VoieData.colonneEtat]);
    this._video = map[VoieData.colonneVideo];
    this._couleur = map[VoieData.colonneCouleur];
    this._commentaire = map[VoieData.colonneCommentaire];
    this._nombreEssais = map[VoieData.colonneNbEssais];
    this._image = map[VoieData.colonneImage];
    this._typeValidation = map[VoieData.colonneFkTypeValidation];
    this._difficulte = map[VoieData.colonneFkDifficulte];
    this._parentId = map[VoieData.colonneFkVoieParent];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this._id != null) {
      map[VoieData.colonnePkId] = this._id;
    }
    map[VoieData.colonneNom] = this._nom;
    map[VoieData.colonneNbPrise] = this._nombre_prise;
    map[VoieData.colonneNbEssais] = this._nombreEssais;
    map[VoieData.colonneEtat] = Tools.boolToInt(this._etat);
    map[VoieData.colonneVideo] = this._video;
    map[VoieData.colonneCouleur] = this._couleur;
    map[VoieData.colonneCommentaire] = this._commentaire;
    map[VoieData.colonneImage] = this._image;
    map[VoieData.colonneFkTypeValidation] = this._typeValidation;
    map[VoieData.colonneFkDifficulte] = this._difficulte;
    map[VoieData.colonneFkVoieParent] = this._parentId;

    return map;
  }

  int get seanceId => _seanceId;

  set seanceId(int value) {
    _seanceId = value;
  }

  int get parentId => _parentId;

  set parentId(int value) {
    _parentId = value;
  }

  String get difficulte => _difficulte;

  set difficulte(String value) {
    _difficulte = value;
  }

  String get typeValidation => _typeValidation;

  set typeValidation(String value) {
    _typeValidation = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get commentaire => _commentaire;

  set commentaire(String value) {
    _commentaire = value;
  }

  String get couleur => _couleur;

  set couleur(String value) {
    _couleur = value;
  }

  String get video => _video;

  set video(String value) {
    _video = value;
  }

  bool get etat => _etat;

  set etat(bool value) {
    _etat = value;
  }

  int get nombre_prise => _nombre_prise;

  set nombre_prise(int value) {
    _nombre_prise = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get nom {
    if (_nom == null || _nom.isEmpty) {
      genererNom();
    }
    return _nom;
  }

  //TODO : Test Unitaire
  void genererNom() async {
    int lastId = await VoieData.getLastItemId();
    if (lastId != null) {
      lastId++;
      _nom = "Voie n°$lastId";
    }
    _nom = "Erreur nom";
  }
}
