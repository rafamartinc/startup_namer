import 'package:flutter/material.dart';
import 'package:startup_namer/entities/startup_name.dart';

class SavedWords extends StatelessWidget {

  final Set<StartupName> saved;
  final TextStyle biggerFont;

  SavedWords({this.saved, this.biggerFont});

  @override
  Widget build(BuildContext context) {

    // Create list of items to be displayed.
    final Iterable<ListTile> tiles = this.saved.map(
      (StartupName pair) {
        return ListTile(
          title: Text(
            pair.name,
            style: this.biggerFont,
          ),
        );
      },
    );

    // Add dividers between the items.
    final List<Widget> divided = ListTile
      .divideTiles(
        context: context,
        tiles: tiles,
      )
      .toList();

    // Build Scaffold.
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}