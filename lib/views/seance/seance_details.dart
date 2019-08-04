import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/voies/voie_seance_liste.dart';

class SeanceDetails extends StatelessWidget {
  final Seance seance;

  SeanceDetails({Key key, @required this.seance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<Voie> voies = SeanceVoieData.getSeanceVoieList(seance.id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(seance.nom),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: getSeanceDetails(this.seance),
          ),
          Text('Voies'),
          SizedBox(
            height: 300.0,
            child: VoieSeanceList(seance: this.seance),
          ),
        ],
      ),
    );
  }

  static List<Widget> getSeanceDetails(Seance seance) {
    var widgets = List<Widget>();

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
