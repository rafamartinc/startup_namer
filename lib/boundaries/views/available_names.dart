import 'package:flutter/material.dart';
import 'package:startup_namer/boundaries/views/saved_names.dart';
import 'package:startup_namer/interactors/name_creation.dart';
import 'package:startup_namer/entities/startup_name.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final List<StartupName> _suggestions = <StartupName>[];
  final Set<StartupName> _saved = Set<StartupName>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {

          if (i.isOdd) {
            return Divider();
          }

          final index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(NameCreation().getNames(10));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(StartupName pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.name,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return SavedWords(saved: _saved, biggerFont: _biggerFont);
        },
      ),
    );
  }
}