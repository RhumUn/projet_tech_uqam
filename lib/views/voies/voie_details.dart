import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';

class VoieDetails extends StatelessWidget {
  final Voie voie;

  VoieDetails({Key key, @required this.voie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(voie.nom),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: getVoieDetails(this.voie),
          ),
        ],
      ),
    );
  }

  static List<Widget> getVoieDetails(Voie voie) {
    var widgets = List<Widget>();

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.whatshot),
      ),
      title: Text("Difficulté :"),
      trailing: ReusableWidgets.getDifficultyTag(voie.difficulte),
    ));

    widgets.add(ReusableWidgets.getValidationWidget(voie));

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.category),
      ),
      title: Text(
        "${voie.nombre_prise} prises",
      ),
    ));

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.color_lens),
      ),
      title: Text(
        "Couleur des prises: ${voie.couleur}",
      ),
    ));

    widgets.add(ListTile(
      leading: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(Icons.comment),
      ),
      title: Text(
        voie.commentaire.isEmpty
            ? "Sans commentaire"
            : "${voie.commentaire}",
      ),
    ));

    return widgets;
  }
}
