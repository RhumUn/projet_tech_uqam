import 'package:flutter/material.dart';

// change `flutter_database` to whatever your project name is
import 'package:flutter_uqam/models/data/VoieData.dart';
import 'package:flutter_uqam/models/bussiness/Voie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  Voie voie = new Voie("V2", 1);

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
              onPressed: () {
                VoieData.insertVoie(voie);
              },
            ),
          ],
        ),
      ),
    );
  }
}

