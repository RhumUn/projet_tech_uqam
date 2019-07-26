class Seance {

  int _id;
  DateTime _date;
  String _lieu;

  Seance(this._lieu){
    this._date = DateTime.now();
  }

  Seance.withId(this._id, this._lieu){
    this._date = DateTime.now();
  }

  Seance.fromMapObject(Map<String, dynamic> map){
    this._id = map["id"];
    this._date = map["date"];
    this._lieu = map["lieu"];
  }

   Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this._id != null){
      map["id"] = this._id;
    }
    map["date"] = this._date;
    map["lieu"] = this._lieu;

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


}