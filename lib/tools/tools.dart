import 'package:flutter/material.dart';

class Tools {
  //TODO : Test Unitaire
  static int boolToInt(bool value) {
    return value ? 1 : 0;
  }

  //TODO : Test Unitaire
  static bool intToBool(int value) {
    return value == 1 ? true : false;
  }

  static Color getDifficultyColor(int difficultyValue) {
    if (difficultyValue < 2) {
      return Colors.green;
    } else if (difficultyValue < 4) {
      return Colors.blue;
    } else if (difficultyValue < 6) {
      return Colors.purple;
    } else if (difficultyValue < 8) {
      return Colors.yellow;
    } else if (difficultyValue < 10) {
      return Colors.red;
    } else if (difficultyValue >= 10) {
      return Colors.black;
    } else {
      return Colors.white70;
    }
  }

  //TODO : Test Unitaire
  static int getDifficultyValue(String difficulty) {
    difficulty = difficulty.replaceAll('V', '');
    return int.tryParse(difficulty);
  }
  //TODO : Test Unitaire
  static IconData getIconTypeValidation(String typeValidation) {
    switch (typeValidation) {
      case "A vue":
        return Icons.remove_red_eye;
        break;
      case "Flash":
        return Icons.flash_on;
        break;
      case "Avec essais":
        return Icons.all_inclusive;
      default:
        return Icons.error_outline;
    }
  }

  //TODO : Test Unitaire
  static IconData getIconEtatValidation(bool etat) {
    IconData value;
    etat ? value = Icons.check : value = Icons.close;
    return value;
  }

  //TODO : Test Unitaire
  static String getEtatValidationText(bool etat) {
    String value;
    etat ? value = "Validée" : value = "Non validée";
    return value;
  }

  //TODO : Test Unitaire
  static parseHourToDatetime(String heureMinutes) {
    List<String> heureSplit = heureMinutes.split(':');
    int heure;
    int minute;

    if (heureSplit.length > 1) {
      heure = int.tryParse(heureSplit[0]);
      minute = int.tryParse(heureSplit[1]);
    }

    if (heure != null && minute != null) {
      return new DateTime(2000, 1, 1, heure, minute);
    } else {
      return new DateTime(2000);
    }
  }

  //TODO : Test Unitaire
  static String dateToString(DateTime date) {
    if (date == null) return "Erreur date";
    String jour;
    String mois;
    String annee;
    date.day != null ? jour = date.day.toString() : jour = "xx";
    date.month != null ? mois = date.month.toString() : mois = "xx";
    date.year != null ? annee = date.year.toString() : annee = "xx";

    return "$jour/$mois/$annee";
  }

  //TODO : Test Unitaire
  static String heureToString(DateTime date) {
    if (date == null) return "Erreur heure";
    String heure;
    String minute;
    date.day != null ? heure = date.hour.toString() : heure = "xx";
    date.minute != null ? minute = date.minute.toString() : minute = "xx";

    return "${heure}h$minute";
  }

  //TODO : Test Unitaire
  static String dureeToString(Duration duree){
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duree.inMinutes.remainder(60));
    return "${twoDigits(duree.inHours)}h$twoDigitMinutes";
  }

  static String minutesToString(int minutes){
    int h = (minutes/60).round();
    int m = minutes % 60;
    return "${h}h$m";
  }
}
