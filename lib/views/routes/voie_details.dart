import 'package:flutter/material.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';

class VoieDetails extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Voie voie;

  // In the constructor, require a Todo.
  VoieDetails({Key key, @required this.voie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(voie.nom),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(voie.commentaire),
      ),
    );
  }
}