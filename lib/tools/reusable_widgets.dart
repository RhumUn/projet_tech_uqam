import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter_uqam/views/voies/voie_details.dart';
import 'package:flutter_uqam/views/voies/voie_liste.dart';

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

  static ListView getVoieListView(List<Voie> voies, Function test) {
    Color color = Colors.white;
    return ListView.builder(
      itemCount: voies.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: color,
          elevation: 2.0,
          child: ListTile(
            leading:
                ReusableWidgets.getDifficultyTag(voies[position].difficulte),
            title: Text(
              voies[position].nom == null ? "Sans nom" : voies[position].nom,
            ),
            subtitle: Text("${voies[position].nombre_prise} prise(s)"),
            trailing: new Row(
              mainAxisSize: MainAxisSize.min,
              children: ReusableWidgets.getValidationIcons(voies[position]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VoieDetails(voie: voies[position]),
                ),
              );
            },
            onLongPress: () {

              Future<ConfirmAction> confirmFuture =
                  _asyncConfirmDialog(context);
              confirmFuture.then((confirm) {
                if (confirm == ConfirmAction.VALIDER)
                  test(context, voies[position]);
              });
            },
          ),
        );
      },
    );
  }

  static Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer la voie ?'),
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

  static List<Widget> getValidationIcons(Voie voie) {
    var widgetList = new List<Widget>();

    if (voie.etat) {
      widgetList.add(Icon(Tools.getIconTypeValidation(voie.typeValidation)));
    }
    widgetList.add(Icon(Tools.getIconEtatValidation(voie.etat)));
    return widgetList;
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
        subtitle: voie.nombreEssais != 0 && voie.nombreEssais != null
            ? Text("${voie.typeValidation}: ${voie.nombreEssais} essais")
            : Text(voie.typeValidation),
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
