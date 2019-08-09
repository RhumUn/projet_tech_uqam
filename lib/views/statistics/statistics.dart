import 'package:flutter/material.dart';
import 'package:flutter_uqam/database_helper.dart';
import 'package:flutter_uqam/models/data/SeanceData.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:sqflite/sqflite.dart';

class Statistiques extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatistiquesState();
  }
}

class StatistiquesState extends State<Statistiques> {
  int _nbVoiesValidees;
  int _nbVoiesNonValidees;
  String _difficulteMaxGrimpe;
  int _nbEssaisMax;
  List<Map<String, int>> _nbVoiesParDifficulte;
  int _tempsTotalGrimpe;
  int _dureeMaxSeance;
  int _dureeMinSeance;
  int _nbVoies;
  int _nbSeances;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: getStatsWidgets(),
    );
  }

  loadData() async {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<int> nbVoiesValideesFuture = VoieData.getCountVoiesByEtat(true);
      nbVoiesValideesFuture.then((nbVoiesValidees) {
        setState(() {
          this._nbVoiesValidees = nbVoiesValidees;
        });
      });

      Future<int> nbVoiesFuture = VoieData.getCount();
      nbVoiesFuture.then((nbVoies) {
        setState(() {
          this._nbVoies = nbVoies;
        });
      });

      Future<int> nbSeancesFuture = SeanceData.getCount();
      nbSeancesFuture.then((nbSeances) {
        setState(() {
          this._nbSeances = nbSeances;
        });
      });

      Future<int> nbVoiesNonValideesFuture =
          VoieData.getCountVoiesByEtat(false);
      nbVoiesNonValideesFuture.then((nbVoiesNonValidees) {
        setState(() {
          this._nbVoiesNonValidees = nbVoiesNonValidees;
        });
      });

      Future<String> difficulteMaxGrimpeFuture = VoieData.getDifficulteMax();
      difficulteMaxGrimpeFuture.then((difficulteMaxGrimpe) {
        setState(() {
          this._difficulteMaxGrimpe = difficulteMaxGrimpe;
        });
      });

      Future<int> nbEssaisMaxFuture = VoieData.getEssaisMax();
      nbEssaisMaxFuture.then((nbEssaisMax) {
        setState(() {
          this._nbEssaisMax = nbEssaisMax;
        });
      });

      Future<int> tempsTotalGrimpeFuture = SeanceData.getTempsTotalGrimpe();
      tempsTotalGrimpeFuture.then((tempsTotalGrimpe) {
        setState(() {
          this._tempsTotalGrimpe = tempsTotalGrimpe;
        });
      });

      Future<int> dureeMaxSeanceFuture = SeanceData.getDureeMaxSeance();
      dureeMaxSeanceFuture.then((dureeMaxSeance) {
        setState(() {
          this._dureeMaxSeance = dureeMaxSeance;
        });
      });

      Future<int> dureeMinSeanceFuture = SeanceData.getDureeMinSeance();
      dureeMinSeanceFuture.then((dureeMinSeance) {
        setState(() {
          this._dureeMinSeance = dureeMinSeance;
        });
      });
    });
  }

  List<Widget> getStatsWidgets() {
    var widgets = List<Widget>();

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        child: Icon(Icons.history),
      ),
      title: Text('$_nbSeances séance(s)'),
    ));

    widgets.add(ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Icons.save),
        ),
        title: Text('$_nbVoies voie(s) enregistrée(s)')));

    widgets.add(ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Icons.done),
        ),
        title: Text('$_nbVoiesValidees voie(s) validée(s)')));

    widgets.add(ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Icons.close),
        ),
        title: Text('$_nbVoiesNonValidees voie(s) non validée(s)')));

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.fitness_center),
      ),
      title: Row(
        children: <Widget>[
          Text('Difficulté max : '),
          _difficulteMaxGrimpe != null ? ReusableWidgets.getDifficultyTag(_difficulteMaxGrimpe): Text('Chargement'),
        ],
      )
    ));

    widgets.add(ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Icons.repeat),
        ),
        title: Text('$_nbEssaisMax essai(s) max sur une voie')));

    widgets.add(ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Icons.timer),
        ),
        title: Text(
            this._tempsTotalGrimpe != null
                ? 'Temps total de grimpe : ${Tools.minutesToString(this._tempsTotalGrimpe)}'
                : 'Erreur')));

    widgets.add(ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Icons.sentiment_very_satisfied),
        ),
        title: Text(
            this._dureeMaxSeance != null
                ? 'Séance la plus longue : ${Tools.minutesToString(this._dureeMaxSeance)}'
                : 'Erreur')));

    widgets.add(ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Icons.sentiment_dissatisfied),
        ),
        title: Text(
            this._dureeMinSeance != null
                ? 'Séance la plus courte : ${Tools.minutesToString(this._dureeMinSeance)}'
                : 'Erreur')));
    return widgets;
  }
}
