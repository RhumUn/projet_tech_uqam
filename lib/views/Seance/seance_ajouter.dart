import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/models/data/SeanceData.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AjouterSeanceForm extends StatefulWidget {
  @override
  AjouterSeanceFormState createState() => new AjouterSeanceFormState();
}

class AjouterSeanceFormState extends State<AjouterSeanceForm> {
  final _formKey = GlobalKey<FormState>();
  final seance = Seance();
  final nomController = TextEditingController();
  final dateController = TextEditingController();
  final heureDebutController = TextEditingController();
  final heureFinController = TextEditingController();
  final lieuController = TextEditingController();
  final commentaireController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: ReusableWidgets.getAppBar("Ajouter une séance"),
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
    dateController.dispose();
    lieuController.dispose();
    commentaireController.dispose();
    super.dispose();
  }

  List<Widget> getFormWidget() {
    final formatDate = DateFormat("yyyy-MM-dd");
    final formatHeure = DateFormat("HH:mm");

    List<Widget> formWidget = new List();

    formWidget.add(new TextFormField(
      decoration: const InputDecoration(
        icon: const Icon(Icons.create),
        hintText: 'Entrez le nom de la séance',
        labelText: 'Nom',
      ),
      controller: nomController,
    ));

    formWidget.add(new Column(children: <Widget>[
      // Text('Date de la séance (${format.pattern})'),
      DateTimeField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.date_range),
          hintText: 'Entrez la date de la séance',
          labelText: 'Date *',
        ),
        format: formatDate,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1950),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        // ignore: missing_return
        validator: (DateTime value) {
          if (value == null) {
            return 'Veuillez entrer une date';
          }
        },
        controller: dateController,
      ),
    ]));

    formWidget.add(new Column(children: <Widget>[
      DateTimeField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.access_time),
          prefixIcon: const Icon(Icons.accessibility_new),
          hintText: "Entrez l'heure de début",
          labelText: "Heure de début",
        ),
        format: formatHeure,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child),
          );
          return DateTimeField.convert(time);
        },
        controller: heureDebutController,
      ),
    ]));

    formWidget.add(new Column(children: <Widget>[
      DateTimeField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.access_time),
          prefixIcon: const Icon(Icons.directions_run),
          hintText: "Entrez l'heure de fin",
          labelText: "Heure de fin",
        ),
        format: formatHeure,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child),
          );
          return DateTimeField.convert(time);
        },
        controller: heureFinController,
      ),
    ]));

    formWidget.add(new TextFormField(
      decoration: const InputDecoration(
        icon: const Icon(Icons.place),
        hintText: 'Entrez le lieu de la séance',
        labelText: 'Lieu',
      ),
      controller: lieuController,
    ));

    formWidget.add(new TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          icon: const Icon(Icons.comment),
          labelText: 'Ecrivez un commentaire sur la séance'),
      controller: commentaireController,
    ));

    formWidget.add(new Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: new RaisedButton(
          child: const Text('Enregistrer'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              seance.nom = nomController.text;
              seance.date = DateTime.tryParse(dateController.text);
              seance.heureDebut =
                  Tools.parseHourToDatetime(heureDebutController.text);
              seance.heureFin =
                  Tools.parseHourToDatetime(heureFinController.text);
              seance.lieu = lieuController.text;
              seance.commentaire = commentaireController.text;
              SeanceData.insertSeance(seance);
              Navigator.pop(context);
            }
          },
        )));

    return formWidget;
  }
}
