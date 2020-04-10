import 'package:english_words/english_words.dart';
import 'package:startup_namer/entities/startup_name.dart';

class NameCreation {

  List<StartupName> getNames(int numNames) {
    Iterable<WordPair> wordPairs = generateWordPairs().take(numNames);

    List<StartupName> startupNames = wordPairs.map(
      (pair) => StartupName(pair.asPascalCase)
    ).toList();

    for(var i = 0; i < startupNames.length; i++) {
      print(startupNames[i].name);
    }

    return startupNames;
  }
}