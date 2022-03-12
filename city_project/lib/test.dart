import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

import 'assets/finally.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chips Input',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _chipKey = GlobalKey<ChipsInputState>();
  @override
  Widget build(BuildContext context) {
    const mockResults = <AppProfile>[
      AppProfile('John Doe', 'jdoe@flutter.io'),
      AppProfile('Paul', 'paul@google.com'),
      AppProfile('Fred', 'fred@google.com'),
      AppProfile('Brian', 'brian@flutter.io'),
      AppProfile('John', 'john@flutter.io'),
      AppProfile('Thomas', 'thomas@flutter.io'),
      AppProfile('Nelly', 'nelly@flutter.io'),
      AppProfile('Marie', 'marie@flutter.io'),
      AppProfile('Charlie', 'charlie@flutter.io'),
      AppProfile('Diana', 'diana@flutter.io'),
      AppProfile('Ernie', 'ernie@flutter.io'),
      AppProfile('Gina', 'fred@flutter.io'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chips Input Example'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChipsInput(
                key: _chipKey,
                /*initialValue: [
                  AppProfile('John Doe', 'jdoe@flutter.io',
                      'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                ],*/
                // autofocus: true,
                // allowChipEditing: true,
                keyboardAppearance: Brightness.dark,
                textCapitalization: TextCapitalization.words,
                // enabled: false,
                // maxChips: 5,
                textStyle: const TextStyle(
                    height: 1.5, fontFamily: 'Roboto', fontSize: 16),
                decoration: const InputDecoration(
                  // prefixIcon: Icon(Icons.search),
                  // hintText: formControl.hint,
                  labelText: 'Select People',
                  // enabled: false,
                  // errorText: field.errorText,
                ),
                findSuggestions: (String query) {
                  // print("Query: '$query'");
                  if (query.isNotEmpty) {
                    var lowercaseQuery = query.toLowerCase();
                    return mockResults.where((profile) {
                      return profile.name
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                          profile.email
                              .toLowerCase()
                              .contains(query.toLowerCase());
                    }).toList(growable: false)
                      ..sort((a, b) => a.name
                          .toLowerCase()
                          .indexOf(lowercaseQuery)
                          .compareTo(
                          b.name.toLowerCase().indexOf(lowercaseQuery)));
                  }
                  // return <AppProfile>[];
                  return mockResults;
                },
                onChanged: (data) {
                  print(data);
                },
                chipBuilder: (context, state, dynamic profile) {
                  return InputChip(
                    key: ObjectKey(profile),
                    label: Text(profile.name),
                    avatar: Container(width: 10,height: 10,color: Red,),
                    onDeleted: () => state.deleteChip(profile),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (context, state, dynamic profile) {
                  return ListTile(
                    key: ObjectKey(profile),
                    leading: Container(width: 10,height: 10,color: Red,),
                    title: Text(profile.name),
                    subtitle: Text(profile.email),
                    onTap: () => state.selectSuggestion(profile),
                  );
                },
              ),
              TextField(),
              /*ChipsInput(
                initialValue: [
                  AppProfile('John Doe', 'jdoe@flutter.io',
                      'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                ],
                enabled: true,
                maxChips: 10,
                textStyle: TextStyle(height: 1.5, fontFamily: "Roboto", fontSize: 16),
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.search),
                  // hintText: formControl.hint,
                  labelText: "Select People",
                  // enabled: false,
                  // errorText: field.errorText,
                ),
                findSuggestions: (String query) {
                  if (query.length != 0) {
                    var lowercaseQuery = query.toLowerCase();
                    return mockResults.where((profile) {
                      return profile.name
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                          profile.email
                              .toLowerCase()
                              .contains(query.toLowerCase());
                    }).toList(growable: false)
                      ..sort((a, b) => a.name
                          .toLowerCase()
                          .indexOf(lowercaseQuery)
                          .compareTo(
                          b.name.toLowerCase().indexOf(lowercaseQuery)));
                  } else {
                    return mockResults;
                  }
                },
                onChanged: (data) {
                  print(data);
                },
                chipBuilder: (context, state, profile) {
                  return InputChip(
                    key: ObjectKey(profile),
                    label: Text(profile.name),
                    avatar: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                    onDeleted: () => state.deleteChip(profile),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (context, state, profile) {
                  return ListTile(
                    key: ObjectKey(profile),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                    title: Text(profile.name),
                    subtitle: Text(profile.email),
                    onTap: () => state.selectSuggestion(profile),
                  );
                },
              ),*/
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AppProfile {
  final String name;
  final String email;
  const AppProfile(this.name, this.email);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppProfile &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return email;
  }
}