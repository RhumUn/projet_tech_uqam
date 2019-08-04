import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/SeanceVoieData.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/voies/voie_ajouter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_uqam/database_helper.dart';

class VoieSeanceList extends StatefulWidget {
  final Seance seance;

  VoieSeanceList({Key key, @required this.seance}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VoieSeanceListState();
  }
}

class VoieSeanceListState extends State<VoieSeanceList> {
  List<Voie> voieList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (voieList == null) {
      voieList = List<Voie>();
      updateListView();
    }

    return Scaffold(
      body: ReusableWidgets.getVoieListView(voieList),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new AjouterVoieForm(seance: widget.seance);
          })).then((value) {
            setState(() {
              updateListView();
            });
          });
        },
        tooltip: 'Add Voie',
        child: Icon(Icons.add),
      ),
    );
  }



 /* void _delete(BuildContext context, Voie voie) async {
    int result = await VoieData.deleteVoieById(voie.id);
    if (result != 0) {
      ReusableWidgets.showSnackBar(context, 'Voie supprimée avec succès');
      updateListView();
    }
  }*/

  void updateListView() {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<List<Voie>> voieListFuture = SeanceVoieData.getSeanceVoieList(widget.seance.id);
      voieListFuture.then((voieList) {
        setState(() {
          voieList != null?this.voieList = voieList:this.voieList = List<Voie>();
          this.count = this.voieList.length;
        });
      });
    });
  }
}
