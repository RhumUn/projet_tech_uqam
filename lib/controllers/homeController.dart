import 'package:mvc_pattern/mvc_pattern.dart';

class Controller extends ControllerMVC {
  int get counter => _counter;
  int _counter = 0;
  void incrementCounter() => _counter++;
}