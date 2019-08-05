import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/voies/voie_details.dart';

class ReusableWidgets {
  static getAppBar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static Widget getDifficultyTag(String difficulty) {
    return CircleAvatar(
      backgroundColor:
      Tools.getDifficultyColor(Tools.getDifficultyValue(difficulty)),
      child: Text(difficulty),
    );
  }

  static List<Widget> getDifficultyTagList(List<String> _difficuties) {
    _difficuties
        .forEach((difficulty) => ReusableWidgets.getDifficultyTag(difficulty));
  }

  static ListView getVoieListView(List<Voie> voies) {
    return ListView.builder(
      itemCount: voies.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading:
            ReusableWidgets.getDifficultyTag(voies[position].difficulte),
            title: Text(
              voies[position].nom == null ? "Sans nom" : voies[position].nom,
            ),
            subtitle: Text("${voies[position].nombre_prise} prise(s)"),
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
                    voies[position].typeValidation)),
                Icon(Tools.getIconEtatValidation(voies[position].etat)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VoieDetails(voie: voies[position]),
                ),
              );
            },
          ),
        );
      },
    );
  }

  static getValidationWidget(Voie voie) {
    if (voie.etat) {
      return ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Tools.getIconEtatValidation(voie.etat)),
        ),
        title: Text(Tools.getEtatValidationText(voie.etat)),
        subtitle: voie.nombreEssais != 0 ? Text("${voie.typeValidation}: ${voie.nombreEssais} essais"):Text(voie.typeValidation),
        trailing: Icon(Tools.getIconTypeValidation(voie.typeValidation)),
      );
    } else {
      return ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Icon(Tools.getIconEtatValidation(voie.etat)),
        ),
        title: Text(
          Tools.getEtatValidationText(voie.etat),
        ),
      );
    }
  }
}