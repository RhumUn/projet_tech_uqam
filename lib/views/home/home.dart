import 'package:flutter/material.dart';
import 'package:flutter_uqam/views/routes/voie_liste.dart';

class HomePage extends StatelessWidget {

  List<Widget> containers = [
    Container(
        child: VoieList()
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.deepPurple,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('MontBloc'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Voies',
              ),
              Tab(
                text: 'Séances',
              ),
              Tab(
                text: 'Stats',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
}

