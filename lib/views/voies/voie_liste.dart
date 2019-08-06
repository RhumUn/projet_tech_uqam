import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/SeanceVoieData.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_uqam/database_helper.dart';

enum ConfirmAction { ANNULER, VALIDER }

class VoieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VoieListState();
  }
}

class VoieListState extends State<VoieList> {
  List<Voie> voieList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (voieList == null) {
      voieList = List<Voie>();
      updateListView();
    }

    return Scaffold(
      body: ReusableWidgets.getVoieListView(voieList, _delete),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<List<Voie>> voieListFuture = VoieData.getVoieList();
      voieListFuture.then((voieList) {
        setState(() {
          this.voieList = voieList;
          this.count = voieList.length;
        });
      });
    });
  }

  void _delete(BuildContext context, Voie voie) async {
    int resultVoie = await VoieData.deleteVoieById(voie.id);
    int resultVoieSeance = await SeanceVoieData.deleteVoieById(voie.id);

    if (resultVoie != 0 && resultVoieSeance != 0) {
      ReusableWidgets.showSnackBar(context, 'Voie supprimée avec succès');
      updateListView();
    }
  }


}
