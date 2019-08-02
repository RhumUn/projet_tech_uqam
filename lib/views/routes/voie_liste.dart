import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/routes/voie_ajouter.dart';
import 'package:flutter_uqam/views/routes/voie_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_uqam/database_helper.dart';

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
      body: getVoieListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new AjouterVoieForm();
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

  ListView getVoieListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: ReusableWidgets.getDifficultyTag(
                this.voieList[position].difficulte),
            title: Text(
              this.voieList[position].nom == null
                  ? "Sans nom"
                  : this.voieList[position].nom,
              style: titleStyle,
            ),
            subtitle: Text("${this.voieList[position].nombre_prise} prise(s)"),
/*            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, voieList[position]);
              },
            ),*/
            trailing: new Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Tools.getIconTypeValidation(
                    voieList[position].typeValidation)),
                Icon(Tools.getIconEtatValidation(
                    Tools.intToBool(voieList[position].etat))),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VoieDetails(voie: voieList[position]),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Voie voie) async {
    int result = await VoieData.deleteVoieById(voie.id);
    if (result != 0) {
      ReusableWidgets.showSnackBar(context, 'Voie supprimée avec succès');
      updateListView();
    }
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
}
