import 'package:flutter/material.dart';
import 'package:flutter_uqam/views/Seance/seance_list.dart';
import 'package:flutter_uqam/views/voies/voie_liste.dart';

class HomePage extends StatelessWidget {

  List<Widget> containers = [
    Container(
        child: VoieList()
    ),
    Container(
        child: SeanceList()
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
          centerTitle: true,
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

