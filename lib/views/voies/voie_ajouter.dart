import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uqam/database_helper.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/SeanceVoieData.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:sqflite/sqflite.dart';

// Create a Form widget.
class AjouterVoieForm extends StatefulWidget {
  final Seance seance;

  AjouterVoieForm({Key key, @required this.seance}) : super(key: key);

  @override
  AjouterVoieFormState createState() => new AjouterVoieFormState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class AjouterVoieFormState extends State<AjouterVoieForm> {
  final _formKey = GlobalKey<FormState>();
  final voie = Voie();
  final nomController = TextEditingController();
  final nbPrisesController = TextEditingController();
  final commentaireController = TextEditingController();

  final List<String> _colors = <String>['Rouge', 'Vert', 'Bleu', 'Orange'];
  final List<String> _typesValidation = <String>[
    'A vue',
    'Flash',
    'Avec essais'
  ];
  final List<String> _difficuties = <String>[
    'V0',
    'V1',
    'V2',
    'V3',
    'V4',
    'V5',
    'V6',
    'V7',
    'V8',
    'V9',
    'V10',
    'V11'
  ];

  Future<int> futureId = VoieData.getLastItemId();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: ReusableWidgets.getAppBar("Ajouter une voie"),
      body: Form(
          key: _formKey,
          child: new ListView(
            padding: const EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
            children: getFormWidget(),
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    nomController.dispose();
    nbPrisesController.dispose();
    commentaireController.dispose();
    super.dispose();
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new TextFormField(
      decoration: const InputDecoration(
        icon: const Icon(Icons.create),
        hintText: 'Entrez le nom de la voie',
        labelText: 'Nom',
      ),
      controller: nomController,
    ));

    formWidget.add(new TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.category),
          hintText: 'Entrez le nombre de prises',
          labelText: 'Nombre de prises',
        ),
        keyboardType: TextInputType.number,
        controller: nbPrisesController));

    formWidget.add(SwitchListTile(
        title: const Text('Voie validée ?'),
        value: voie.etat,
        secondary: const Icon(Icons.check),
        onChanged: (bool val) {
          setState(() => voie.etat = val);
          formWidget.add(new FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.playlist_add_check),
                  labelText: 'Type de validation',
                ),
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: voie.typeValidation,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        //newContact.favoriteColor = newValue;
                        voie.typeValidation = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _typesValidation.map((String value) {
                      return new DropdownMenuItem(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(child: Text(value)),
                            Container(
                              child: Icon(
                                Tools.getIconTypeValidation(value),
                                color: Colors.blue[500],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ));
        }
    ));

    formWidget.add(new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.whatshot),
            labelText: 'Difficulté',
          ),
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: voie.difficulte,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  voie.difficulte = newValue;
                  state.didChange(newValue);
                });
              },
              items: _difficuties.map((String value) {
                return new DropdownMenuItem(
                  value: value,
                  child: ReusableWidgets.getDifficultyTag(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    ));



    formWidget.add(new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.color_lens),
            labelText: 'Couleur',
          ),
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: _colors[0],
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  voie.couleur = newValue;
                  state.didChange(newValue);
                });
              },
              items: _colors.map((String value) {
                return new DropdownMenuItem(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    ));

    formWidget.add(new TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: commentaireController,
      decoration: InputDecoration(
          icon: const Icon(Icons.comment), labelText: 'Ecrivez un commentaire'),
    ));

    formWidget.add(new Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: new RaisedButton(
          child: const Text('Valider'),
          onPressed: () {
            voie.nom = nomController.text;
            voie.commentaire = commentaireController.text;
            voie.nombre_prise = int.parse(nbPrisesController.text);
            addSeanceVoie();
            Navigator.pop(context);
          },
        )));
    return formWidget;
  }

  void addSeanceVoie() {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<int> idVoieFuture = VoieData.insertVoie(voie);
      idVoieFuture.then((idVoie) {
        SeanceVoieData.insertSeanceVoie(widget.seance.id, idVoie);
      });
    });
  }
}
