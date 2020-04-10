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

    var padding = const EdgeInsets.all(16.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return ListView.builder(
              padding: padding,
              itemBuilder: (context, i) {

                if (i >= _suggestions.length) {
                  _suggestions.addAll(NameCreation().getNames(10));
                }

                return _buildItem(_suggestions[i]);
              });
          } else {
              return GridView.builder(
                padding: padding,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5 * MediaQuery.of(context).size.width / MediaQuery.of(context).size.height
                
                ),
                itemBuilder: (context, i) {

                if (i >= _suggestions.length) {
                  _suggestions.addAll(NameCreation().getNames(10));
                }

                return _buildItem(_suggestions[i]);
              }
            );
          }
        }
      ),
    );
  }

  Widget _buildItem(StartupName pair) {
    final bool alreadySaved = _saved.contains(pair);

    return Container(
      height: 80,

      child: Padding(
        padding: EdgeInsets.all(8.0),

        child: InkWell(
          focusColor: Colors.blue[50],

          child: Row(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Icon(
                    alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved ? Colors.red : null,
                    size: 40.0,
                  )
                ),
              ),

              Center(
                child: Container(
                  child: Text(
                    pair.name,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),

            ], 
          ),

          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(pair);
              } else {
                _saved.add(pair);
              }
            });
          },
        ),
      ),
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