import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/SeanceData.dart';
import 'package:flutter_uqam/models/data/SeanceVoieData.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/Seance/seance_ajouter.dart';
import 'package:flutter_uqam/views/seance/seance_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_uqam/database_helper.dart';

enum ConfirmAction { ANNULER, VALIDER }

class SeanceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SeanceListState();
  }
}

class SeanceListState extends State<SeanceList> {
  List<Seance> seanceList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (seanceList == null) {
      seanceList = List<Seance>();
      updateListView();
    }

    return Scaffold(
      body: getSeanceListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new AjouterSeanceForm();
          })).then((value) {
            setState(() {
              updateListView();
            });
          });
        },
        tooltip: 'Ajouter une séance',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getSeanceListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              this.seanceList[position].nom,
              style: titleStyle,
            ),
            subtitle: Row(
              children: [
                Text(
                    "Date : ${Tools.dateToString(this.seanceList[position].date)} - "),
                this.seanceList[position].heureFin != DateTime(2000, 1, 1)
                    ? Icon(Icons.timelapse)
                    : Icon(Icons.access_time),
                this.seanceList[position].heureFin != DateTime(2000, 1, 1)
                    ? Text(this.seanceList[position].dureeSeance())
                    : Text(Tools.heureToString(
                        this.seanceList[position].heureDebut)),
                Text(' - ${this.seanceList[position].voieList.length} voie(s)')
              ],
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                Future<ConfirmAction> confirmFuture =
                    _asyncConfirmDialog(context);
                confirmFuture.then((confirm) {
                  if (confirm == ConfirmAction.VALIDER)
                    _delete(context, seanceList[position]);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SeanceDetails(seance: seanceList[position]),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Seance seance) async {
    int resultSeance = await SeanceData.deleteSeanceById(seance.id);
    int resultSeanceVoies = await SeanceVoieData.deleteSeanceVoies(seance.id);

    if (resultSeance != 0 && resultSeanceVoies != 0) {
      ReusableWidgets.showSnackBar(context, 'Séance supprimée avec succès');
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<List<Seance>> seanceListFuture = SeanceData.getSeanceList();
      seanceListFuture.then((seanceList) {
        setState(() {
          this.seanceList = seanceList;
          this.count = seanceList.length;
        });
        for (final seance in seanceList) {
          Future<List<Voie>> idVoieFuture = seance.getFutureVoieList();
          idVoieFuture.then((listVoie) {
            setState(() {
              seance.voieList = listVoie;
            });
          });
        }
      });
    });
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer la séance ?'),
          content: const Text(
              'Cela supprimera toutes les informations liées à la séance.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('ANNULER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ANNULER);
              },
            ),
            FlatButton(
              child: const Text('VALIDER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.VALIDER);
              },
            )
          ],
        );
      },
    );
  }
}
