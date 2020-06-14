import 'package:flutter/material.dart';
import 'package:jokesflutterapp/JokesListView.dart';

//Custom widgets
import 'JokesListView.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Jokes App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Jokes App'),
        ),
        body: Center(
            child: JokesListView()
        ),
      ),
    );
  }
}