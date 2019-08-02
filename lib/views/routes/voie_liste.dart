import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/routes/voie_ajouter.dart';
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
            leading: ReusableWidgets.getDifficultyTag(this.voieList[position].difficulte),
            title: Text(
              this.voieList[position].nom == ""?"Sans nom":this.voieList[position].nom,
              style: titleStyle,
            ),
            subtitle:
                Text("Validée: ${this.voieList[position].getEtat()}"),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, voieList[position]);
              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              //navigateToDetail(this.voieList[position],'Détails voie');
            },
          ),
        );
      },
    );
  }



  void _delete(BuildContext context, Voie voie) async {
    int result = await VoieData.deleteVoieById(voie.id);
    if (result != 0) {
      ReusableWidgets.showSnackBar(context, 'Voie Deleted Successfully');
      updateListView();
    }
  }



  void navigateToDetail(Voie voie) async {
    /*bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return voie;
    }));

    if (result == true) {
      updateListView();
    }*/
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
