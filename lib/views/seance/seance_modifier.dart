import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uqam/models/bussiness/Seance.dart';
import 'package:flutter_uqam/models/data/SeanceData.dart';
import 'package:flutter_uqam/tools/reusable_widgets.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ModifierSeanceForm extends StatefulWidget {
  final Seance seance;

  ModifierSeanceForm({Key key, @required this.seance}) : super(key: key);

  @override
  ModifierSeanceFormState createState() => new ModifierSeanceFormState();
}

class ModifierSeanceFormState extends State<ModifierSeanceForm> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final dateController = TextEditingController();
  final heureDebutController = TextEditingController();
  final heureFinController = TextEditingController();
  final lieuController = TextEditingController();
  final commentaireController = TextEditingController();
  final formatDate = DateFormat("yyyy-MM-dd");
  final formatHeure = DateFormat("HH:mm");

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
  void initState() {
    nomController.text = widget.seance.nom;
    commentaireController.text = widget.seance.commentaire;
    dateController.text = formatDate.format(widget.seance.date);
    lieuController.text = widget.seance.lieu;
    heureDebutController.text = formatHeure.format(widget.seance.heureDebut);
    heureFinController.text = formatHeure.format(widget.seance.heureFin);
    return super.initState();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    nomController.dispose();
    dateController.dispose();
    lieuController.dispose();
    commentaireController.dispose();
    heureDebutController.dispose();
    heureFinController.dispose();
    super.dispose();
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        icon: const Icon(Icons.create),
        hintText: 'Entrez le nom de la séance',
        labelText: 'Nom',
      ),
      controller: nomController,
    ));

    formWidget.add(new Column(children: <Widget>[
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
              initialDate: widget.seance.date ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        // ignore: missing_return
        validator: (v) {
          if (dateController.text == null || dateController.text.isEmpty)
            return "Veuillez rentrer une date";
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
          labelText: "Heure de début *",
        ),
        format: formatHeure,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: widget.seance.heureDebut != null
                ? TimeOfDay.fromDateTime(widget.seance.heureDebut)
                : TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child),
          );
          return DateTimeField.convert(time);
        },
        // ignore: missing_return
        validator: (v) {
          if (heureDebutController.text == null || heureDebutController.text.isEmpty)
            return "Veuillez rentrer une heure de début";
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
            initialTime: widget.seance.heureFin != null
                ? TimeOfDay.fromDateTime(widget.seance.heureFin)
                : TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
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
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        icon: const Icon(Icons.place),
        hintText: 'Entrez le lieu de la séance',
        labelText: 'Lieu',
      ),
      controller: lieuController,
    ));

    formWidget.add(new TextFormField(
      textCapitalization: TextCapitalization.sentences,
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
              if (nomController.text.isEmpty) {
                widget.seance.nom = "Sans nom";
              } else {
                widget.seance.nom = nomController.text;
              }
              widget.seance.date = DateTime.tryParse(dateController.text);
              widget.seance.heureDebut =
                  Tools.parseHourToDatetime(heureDebutController.text);
              widget.seance.heureFin =
                  Tools.parseHourToDatetime(heureFinController.text);
              widget.seance.lieu = lieuController.text;
              widget.seance.commentaire = commentaireController.text;
              SeanceData.updateSeance(widget.seance);
              Navigator.pop(context, widget.seance);
            }
          },
        )));

    return formWidget;
  }
}
