import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_uqam/controllers/homeController.dart';

class MyApp extends AppMVC {
  MyApp({Key key}) : super(key: key);

  static final String title = 'Flutter Demo Home Page';
  final MyHomePage home = MyHomePage(title);

  ControllerMVC get controller => home.controller;

  /// This is 'the View' for this application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title, {Key key}) : super(key: key);
  final String title;
  final _MyHomePageState state = _MyHomePageState();

  Controller get controller => state.controller;

  @override
  State createState() => state;
}

class _MyHomePageState extends StateMVC<MyHomePage> {
  _MyHomePageState() : super(Controller()) {
    _con = controller;
  }
  Controller _con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take a property value from the MyHomePage Widget, and we use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
            ),
            Text(
              '${_con.counter}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(_con.incrementCounter);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}