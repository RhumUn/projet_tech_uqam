import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/voies/voie_seance_liste.dart';
import 'package:sqflite/sqflite.dart';

import '../../database_helper.dart';

class SeanceDetails extends StatefulWidget {
  final Seance seance;

  SeanceDetails({Key key, @required this.seance}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SeanceDetailsState();
  }
}

class SeanceDetailsState extends State<SeanceDetails> {
  @override
  Widget build(BuildContext context) {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<List<Voie>> idVoieFuture = widget.seance.getFutureVoieList();
      idVoieFuture.then((listVoie) {
        setState(() {
          widget.seance.voieList = listVoie;
        });
      });
    });
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(widget.seance.nom),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: getSeanceDetails(widget.seance),
          ),
          Text(
            '${widget.seance.voieList.length} voie(s)',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 250.0, //TODO : Non dynamique
            child: VoieSeanceList(seance: widget.seance),
          ),
        ],
      ),
    );
  }

  static List<Widget> getSeanceDetails(Seance seance) {
    var widgets = List<Widget>();
    bool showDuree = seance.heureDebut != null &&
        seance.heureFin != null &&
        seance.heureFin != DateTime(2000, 1, 1);

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.date_range),
      ),
      title: Text("${Tools.dateToString(seance.date)}"),
    ));

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.access_time),
      ),
      title: Text("${Tools.heureToString(seance.heureDebut)}"),
      subtitle: Text(seance.heureFin == DateTime(2000, 1, 1)
          ? "Heure de fin : Inconnue"
          : "Heure de fin: ${Tools.heureToString(seance.heureFin)}"),
    ));

    widgets.add(Visibility(
        child: ListTile(
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: Icon(Icons.timelapse),
          ),
          title: Text(
            showDuree ? "Durée: ${seance.dureeSeance()}" : "",
          ),
        ),
        visible: showDuree));

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.place),
      ),
      title: Text(
        seance.lieu.isEmpty ? "Sans lieu" : "${seance.lieu}",
      ),
    ));

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.comment),
      ),
      title: Text(
        seance.commentaire.isEmpty
            ? "Sans commentaire"
            : "${seance.commentaire}",
      ),
    ));

    return widgets;
  }
}
