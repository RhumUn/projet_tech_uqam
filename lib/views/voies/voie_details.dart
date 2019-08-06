import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';
import 'package:flutter_uqam/views/voies/voie_modifier.dart';

class VoieDetails extends StatefulWidget {
  Voie voie;

  VoieDetails({Key key, @required this.voie}) : super(key: key);
  @override
  VoieDetailsState createState() => new VoieDetailsState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class VoieDetailsState extends State<VoieDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.voie.nom),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.mode_edit),
            onPressed: () {
              navigateToSubPage(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: getVoieDetails(widget.voie),
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
        voie.commentaire.isEmpty ? "Sans commentaire" : "${voie.commentaire}",
      ),
    ));

    return widgets;
  }

  /*void updateListView() {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<Voie> voieFuture = VoieData.getVoieById(widget.voie.id);
      voieListFuture.then((voieList) {
        setState(() {
          this.voieList = voieList;
          this.count = voieList.length;
        });
      });
    });
  }*/

  Future navigateToSubPage(context) async {
    Voie voieModifiee = await Navigator.push(context, MaterialPageRoute(builder: (context) => ModifierVoieForm(voie: widget.voie)));
    setState(() {
      widget.voie = voieModifiee;
    });
  }
}
