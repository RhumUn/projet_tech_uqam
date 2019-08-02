import 'package:flutter/material.dart';

class Tools {
  static int boolToInt(bool value) {
    return value ? 1 : 0;
  }

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
    } else if (difficultyValue > 10) {
      return Colors.black;
    } else {
      return Colors.white70;
    }
  }

  static int getDifficultyValue(String difficulty) {
    difficulty = difficulty.replaceAll('V', '');
    return int.tryParse(difficulty);
  }

  static List<Widget> getDifficultyTagList(List<String> _difficuties) {
    _difficuties
        .forEach((difficulty) => ReusableWidgets.getDifficultyTag(difficulty));
  }

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

  static IconData getIconEtatValidation(bool etat) {
    IconData value;
    etat ? value = Icons.check : value = Icons.close;
    return value;
  }

  static parseHourToDatetime(String heureMinutes) {
    List<String> heureSplit = heureMinutes.split(':');
    int heure;
    int minute;

    if (heureSplit.length > 1){
       heure = int.tryParse(heureSplit[0]);
       minute = int.tryParse(heureSplit[1]);
    }

    if (heure != null && minute != null) {
      return new DateTime(2000, 1, 1, heure, minute);
    } else {
      return new DateTime(2000);
    }
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

  static Widget getDifficultyTag(String difficulty) {
    return CircleAvatar(
      backgroundColor:
          Tools.getDifficultyColor(Tools.getDifficultyValue(difficulty)),
      child: Text(difficulty),
    );
  }
}
