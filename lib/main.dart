import 'package:flutter/material.dart';
import 'package:flutter_uqam/views/home/home.dart';
import 'package:flutter_uqam/views/routes/voie_ajouter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MontBloc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
        routes: <String, WidgetBuilder> {
          "ajouter_voie" : (BuildContext context) => new AjouterVoieForm(),
        }
    );
  }
}



