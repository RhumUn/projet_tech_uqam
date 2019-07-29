import 'package:flutter/material.dart';

class Tools{
  static int boolToInt(bool value) {
    return value ? 1 : 0;
  }

  static Color getDifficultyColor(String difficulty) {
    Color value = Colors.white70;
    (difficulty == 'V0' || difficulty == 'V1')? value = Colors.green : value = value;
    (difficulty == 'V2' || difficulty == 'V3')? value = Colors.blue : value = value;
    (difficulty == 'V4' || difficulty == 'V5')? value = Colors.purple : value = value;
    (difficulty == 'V6' || difficulty == 'V7')? value = Colors.yellow : value = value;
    (difficulty == 'V8' || difficulty == 'V9')? value = Colors.red : value = value;
    (difficulty == 'V10' || difficulty == 'V11' || difficulty == 'V12')? value = Colors.black : value = value;

    return value;
  }
}

class ReusableWidgets {
  static getAppBar(String title) {
    return AppBar(
      title: Text(title),
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static Widget getDifficultyTag(String difficulty){
    return CircleAvatar(
      backgroundColor:
      Tools.getDifficultyColor(difficulty),
      child: Text(difficulty),
    );
  }
}