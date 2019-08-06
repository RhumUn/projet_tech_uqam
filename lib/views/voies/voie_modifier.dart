import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uqam/database_helper.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:sqflite/sqflite.dart';

// Create a Form widget.
class ModifierVoieForm extends StatefulWidget {
  final Voie voie;

  ModifierVoieForm({Key key, @required this.voie}) : super(key: key);

  @override
  ModifierVoieFormState createState() => new ModifierVoieFormState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class ModifierVoieFormState extends State<ModifierVoieForm> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final nbPrisesController = TextEditingController();
  final commentaireController = TextEditingController();
  final nbEssaisController = TextEditingController();

  final List<String> _colors = <String>['Rouges', 'Vertes', 'Bleues', 'Oranges', 'Mauves', 'Marbrées', 'Noires', 'Blanches'];
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
  void initState() {
    nomController.text = widget.voie.nom;
    commentaireController.text = widget.voie.commentaire;
    nbPrisesController.text = widget.voie.nombre_prise.toString();
    widget.voie.nombreEssais == null?nbEssaisController.text = "0":nbEssaisController.text = widget.voie.nombreEssais.toString();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      appBar: ReusableWidgets.getAppBar("Modifier une voie"),
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
    nbEssaisController.dispose();
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
      controller: nbPrisesController,
    ));

    formWidget.add(SwitchListTile(
        title: const Text('Voie validée ?'),
        value: widget.voie.etat,
        secondary: const Icon(Icons.check),
        onChanged: (bool val) {
          setState(() => widget.voie.etat = val);
        }));

    formWidget.add(Visibility(
        child: new FormField(
          builder: (FormFieldState state) {
            return InputDecorator(
              decoration: InputDecoration(
                icon: const Icon(Icons.playlist_add_check),
                labelText: 'Type de validation',
              ),
              child: new DropdownButtonHideUnderline(
                child: new DropdownButton(
                  value: widget.voie.typeValidation,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      widget.voie.typeValidation = newValue;
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
        ),
        visible: widget.voie.etat));

    formWidget.add(Visibility(
        child: new TextFormField(
          decoration: const InputDecoration(
            icon: const Icon(Icons.category),
            hintText: "Entrez le nombre d'essais",
            labelText: "Nombre d'essais",
          ),
          keyboardType: TextInputType.number,
          controller: nbEssaisController,
        ),
        visible:
            widget.voie.typeValidation == "Avec essais" && widget.voie.etat));

    formWidget.add(new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.whatshot),
            labelText: 'Difficulté',
          ),
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: widget.voie.difficulte,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  widget.voie.difficulte = newValue;
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
            labelText: 'Couleur des prises',
          ),
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: widget.voie.couleur==null || widget.voie.couleur.isEmpty?_colors[0]:widget.voie.couleur,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  widget.voie.couleur = newValue;
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
            widget.voie.nom = nomController.text;
            widget.voie.commentaire = commentaireController.text;
            widget.voie.nombre_prise = int.tryParse(nbPrisesController.text);
            widget.voie.nombreEssais = int.tryParse(nbEssaisController.text);
            modifierVoie();
          },
        )));

    return formWidget;
  }

  void modifierVoie() {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then((database) {
      Future<int> idVoieFuture = VoieData.updateVoie(widget.voie);
      idVoieFuture.then((idVoie) {
        Navigator.pop(context, widget.voie);
      });
    });
  }
}
