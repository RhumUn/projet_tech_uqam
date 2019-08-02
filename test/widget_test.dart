// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uqam/tools/tools.dart';

void main() {
  test('parseHourToDatetime', () {
    expect(Tools.parseHourToDatetime("18:49"), new DateTime(2000, 1, 1, 18, 49));
    expect(Tools.parseHourToDatetime("01:12"), new DateTime(2000, 1, 1, 01, 12));
    expect(Tools.parseHourToDatetime("qsdqsdqsd"), new DateTime(2000));
    expect(Tools.parseHourToDatetime(""), new DateTime(2000));
  });
}
