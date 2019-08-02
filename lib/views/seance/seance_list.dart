import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/models/data/SeanceData.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/Seance/seance_ajouter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_uqam/database_helper.dart';

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
          debugPrint('FAB clicked');
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new AjouterSeanceForm();
          })).then((value) {
            setState(() {
              updateListView();
            });
          });
        },
        tooltip: 'Add Séance',
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
            subtitle: Text(
              "Date : ${Tools.dateToString(this.seanceList[position].date)} - "
              "${Tools.heureToString(this.seanceList[position].heureDebut)}",
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, seanceList[position]);
              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              //navigateToDetail(this.seanceList[position],'Edit Seance');
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Seance seance) async {
    int result = await SeanceData.deleteSeanceById(seance.id);
    if (result != 0) {
      ReusableWidgets.showSnackBar(context, 'Séance supprimée avec succés');
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
      });
    });
  }
}
