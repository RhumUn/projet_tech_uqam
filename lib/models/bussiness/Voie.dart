import 'package:flutter_uqam/models/data/VoieData.dart';

class Voie {
  int _id;
  int _nombre_prise;
  bool _estValidee;
  String _video;
  String _couleur;
  String _commentaire;
  String _image;
  String _typeValidation;
  String _difficulte;
  int _parentId;
  int _seanceId;

  Voie(this._difficulte, this._seanceId) {
    this._estValidee = false;
    this._typeValidation = "non_validee";
  }

  Voie.withParentId(this._difficulte, this._seanceId, this._parentId) {
    this._estValidee = false;
    this._typeValidation = "non_validee";
  }

  Voie.withId(this._id, this._difficulte, this._seanceId) {
    this._estValidee = false;
    this._typeValidation = "non_validee";
  }

  Voie.fromMapObject(Map<String, dynamic> map) {
    this._id = map[VoieData.colonnePkId];
    this._nombre_prise = map[VoieData.colonneNbPrise];
    this._estValidee = map[VoieData.colonneEtat];
    this._video = map[VoieData.colonneVideo];
    this._couleur = map[VoieData.colonneCouleur];
    this._commentaire = map[VoieData.colonneCommentaire];
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
    map[VoieData.colonneNbPrise] = this._nombre_prise;
    map[VoieData.colonneEtat] = this._estValidee;
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

  bool get estValidee => _estValidee;

  set estValidee(bool value) {
    _estValidee = value;
  }

  int get nombre_prise => _nombre_prise;

  set nombre_prise(int value) {
    _nombre_prise = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
