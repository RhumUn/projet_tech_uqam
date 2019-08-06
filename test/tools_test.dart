import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_uqam/tools/tools.dart';
import 'package:test/test.dart';

void main() {
  test('boolToInt', () {
      int expectedValue;

      expectedValue = Tools.boolToInt(true);
      expect(expectedValue, 1);

      expectedValue = Tools.boolToInt(false);
      expect(expectedValue, 0);
  });

  test('intToBool', () {
    bool expectedValue;

    expectedValue = Tools.intToBool(0);
    expect(expectedValue, false);

    expectedValue = Tools.intToBool(1);
    expect(expectedValue, true);

    expectedValue = Tools.intToBool(15);
    expect(expectedValue, false);
  });

  test('getDifficultyValue', () {
    int expectedValue;

    expectedValue = Tools.getDifficultyValue("V2");
    expect(expectedValue, 2);
    expectedValue = Tools.getDifficultyValue("V215");
    expect(expectedValue, 215);
    expectedValue = Tools.getDifficultyValue("A2");
    expect(expectedValue, null);
  });

  test('getDifficultyColor', () {
    Color expectedValue;

    expectedValue = Tools.getDifficultyColor(0);
    expect(expectedValue, Colors.green);
    expectedValue = Tools.getDifficultyColor(1);
    expect(expectedValue, Colors.green);
    expectedValue = Tools.getDifficultyColor(2);
    expect(expectedValue, Colors.blue);
    expectedValue = Tools.getDifficultyColor(4);
    expect(expectedValue, Colors.purple);
    expectedValue = Tools.getDifficultyColor(6);
    expect(expectedValue, Colors.yellow);
    expectedValue = Tools.getDifficultyColor(9);
    expect(expectedValue, Colors.red);
    expectedValue = Tools.getDifficultyColor(11);
    expect(expectedValue, Colors.black);
    expectedValue = Tools.getDifficultyColor(54);
    expect(expectedValue, Colors.black);
  });

  test('getDifficultyValue', () {
    IconData expectedValue;

    expectedValue = Tools.getIconTypeValidation("test");
    expect(expectedValue, Icons.error_outline);
    expectedValue = Tools.getIconTypeValidation("");
    expect(expectedValue, Icons.error_outline);
    expectedValue = Tools.getIconTypeValidation("A vue");
    expect(expectedValue, Icons.remove_red_eye);
    expectedValue = Tools.getIconTypeValidation("Flash");
    expect(expectedValue, Icons.flash_on);
    expectedValue = Tools.getIconTypeValidation("Avec essais");
    expect(expectedValue, Icons.all_inclusive);
  });

  test('getIconEtatValidation', () {
    IconData expectedValue;

    expectedValue = Tools.getIconEtatValidation(true);
    expect(expectedValue, Icons.check);
    expectedValue = Tools.getIconEtatValidation(false);
    expect(expectedValue, Icons.close);
  });

  test('minutesToHourMinutesString', () {
    String expectedValue;

    //expectedValue = Tools.dureeToString(90);
    expect(expectedValue, "1h30");
  });
}