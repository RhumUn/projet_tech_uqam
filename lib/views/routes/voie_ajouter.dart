import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/views/home/home.dart';
import 'package:flutter_uqam/tools/tools.dart';

// Create a Form widget.
class AjouterVoieForm extends StatefulWidget {
  @override
  AjouterVoieFormState createState() => new AjouterVoieFormState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class AjouterVoieFormState extends State<AjouterVoieForm> {
  final _formKey = GlobalKey<FormState>();
  final voie = Voie();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: ReusableWidgets.getAppBar("Ajouter une voie"),
      body: Form(
          key: _formKey,
          child: new ListView(
            children: getFormWidget(),
          )),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();
    List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
    List<String> _difficuties = <String>[
      '',
      'V0',
      'V1',
      'V2',
      'V3',
      'V4',
      'V6',
      'V7',
      'V8',
      'V9',
      'V10',
      'V11'
    ];

    String _color = '';

    formWidget.add(new TextFormField(
      decoration: const InputDecoration(
        icon: const Icon(Icons.create),
        hintText: 'Entrez le nom de la voie',
        labelText: 'Nom',
      ),
    ));

    formWidget.add(new TextFormField(
      decoration: const InputDecoration(
        icon: const Icon(Icons.category),
        hintText: 'Enter le nombre de prises',
        labelText: 'Nombre de prises',
      ),
      keyboardType: TextInputType.datetime,
    ));

    formWidget.add(SwitchListTile(
        title: const Text('Voie validée ?'),
        value: false,
        secondary: const Icon(Icons.check),
        onChanged: (bool val) =>
            setState(() => voie.etat = Tools.boolToInt(val))));

    formWidget.add(new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.whatshot),
            labelText: 'Difficulté',
          ),
          isEmpty: _color == '',
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: voie.difficulte,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  //newContact.favoriteColor = newValue;
                  voie.difficulte = newValue;
                  state.didChange(newValue);
                });
              },
              items: _difficuties.map((String value) {
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

    formWidget.add(new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.color_lens),
            labelText: 'Couleur',
          ),
          isEmpty: _color == '',
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: _color,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  //newContact.favoriteColor = newValue;
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

    formWidget.add(new Container(
        padding: const EdgeInsets.only(left: 40.0, top: 20.0),
        child: new RaisedButton(
          child: const Text('Submit'),
          onPressed: () {
            VoieData.insertVoie(voie);
            Navigator.pop(context);
          },
        )));

    return formWidget;
  }
}
