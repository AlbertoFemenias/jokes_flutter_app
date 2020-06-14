import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Joke {
  final int id;
  final String setup;
  final String delivery;
  final String category;

  Joke(this.id, this.setup, this.delivery, this.category);
}

class JokesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Joke>>(
      future: _fetchJokes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Joke> data = snapshot.data;
          return _jokesListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Joke>> _fetchJokes() async {
    final jokesAPIUrl = 'https://sv443.net/jokeapi/v2/joke/Any?type=twopart';

    List<Joke> jokes = [];
    for (var i = 0; i < 20; i++) {
      final response = await http.get(jokesAPIUrl);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        Joke joke = Joke(jsonData["id"], jsonData["setup"], jsonData["delivery"], jsonData["category"]);
        jokes.add(joke);
      }
    }
    return jokes;
  }

    ListView _jokesListView(data) {
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _tile(context, data[index]);
          });
    }

    ListTile _tile(BuildContext context, Joke joke) =>
        ListTile(
          title: Text(joke.setup,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
          subtitle: Text(joke.category),
          onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(joke))); },
        );
}

class DetailPage extends StatelessWidget {

  final Joke joke;
  DetailPage(this.joke);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detailed Joke"),
        ),
        body: Padding(
            padding: new EdgeInsets.all(10.0),
            child: Column(
              children: [
                new Text(joke.setup,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 20,
                  ),),
                new Text(""),
                new Text(joke.delivery,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    fontSize: 20,
                  ),),
                new Text(""),
                new Text(joke.category,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    fontSize: 15,
                  ),),
              ]
            ),
        ),
    );
  }
}