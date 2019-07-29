import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
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
          }));
          //VoieData.insertVoie(Voie("V4", 1));
          //updateListView();
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

            leading: CircleAvatar(
              backgroundColor: getDifficultyColor(this.voieList[position].difficulte),
              //child: getPriorityIcon(this.voieList[position].priority),
            ),

            title: Text(this.voieList[position].id.toString(), style: titleStyle,),

            subtitle: Text("Validée: ${this.voieList[position].etat.toString()}"),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, voieList[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              //navigateToDetail(this.voieList[position],'Edit Voie');
            },

          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "V0":
        return Colors.green;
        break;
      case "V2":
        return Colors.blue;
        break;
      case "V4":
        return Colors.purple;
        break;

      default:
        return Colors.white70;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Voie voie) async {

    int result = await VoieData.deleteVoieById(voie.id);
    if (result != 0) {
      _showSnackBar(context, 'Voie Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

/*  void navigateToDetail(Voie voie) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return voie;
    }));

    if (result == true) {
      updateListView();
    }
  }*/

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