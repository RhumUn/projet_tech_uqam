import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/tools/tools.dart';

class SeanceDetails extends StatelessWidget {
  final Seance seance;

  SeanceDetails({Key key, @required this.seance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(seance.nom),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Container(
                width: 40,
                alignment: Alignment.center,
                child: Icon(Icons.date_range),
              ),
              title: Text(
                  "${Tools.dateToString(this.seance.date)}"),
            ),
            ListTile(
              leading: Container(
                width: 40,
                alignment: Alignment.center,
                child: Icon(Icons.access_time),
              ),
              title:
                  Text("${Tools.heureToString(this.seance.heureDebut)}"),
              subtitle: Text(this.seance.heureFin == DateTime(2000, 1, 1)
                  ? "Heure de fin : Inconnue"
                  : "Heure de fin: ${Tools.heureToString(this.seance.heureFin)}"),
            ),
            ListTile(
              leading: Container(
                width: 40,
                alignment: Alignment.center,
                child: Icon(Icons.place),
              ),
              title: Text(
                this.seance.lieu.isEmpty ? "Sans lieu" : "${this.seance.lieu}",
              ),
            ),
            ListTile(
              leading: Container(
                width: 40,
                alignment: Alignment.center,
                child: Icon(Icons.comment),
              ),
              title: Text(
                this.seance.commentaire.isEmpty
                    ? "Sans commentaire"
                    : "${this.seance.commentaire}",
              ),
            ),

          ],
        ));
  }
}
