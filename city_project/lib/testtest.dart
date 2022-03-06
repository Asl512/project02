import 'package:flutter/material.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget listRow(int profile, int image, int likes, String name, String text) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              CircleAvatar(
                backgroundImage:
                NetworkImage('https://picsum.photos/800?image=$profile'),
              ),
              SizedBox(width: 8),
              Text(name)
            ]),
          ),
          ZoomOverlay(
              minScale: 0.5, // optional
              maxScale: 3.0, // optional
              twoTouchOnly: true,
              child: Image.network('https://bipbap.ru/wp-content/uploads/2017/04/priroda_kartinki_foto_03.jpg')
          ),

        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Text('Instagram')),
        body: ListView(
          children: <Widget>[
            listRow(1027, 1062, 36, 'mary.porter',
                'Lucy doesnt want to get out of bed today, its far too cold for the little darling.'),
            listRow(324, 557, 65, 'paul.bishop',
                'Looks like its going to be a rough crossing.'),
            listRow(453, 585, 29, 'mel_fortwright',
                'The stands are packed, this is going to be a good game !'),
            listRow(64, 653, 18, 'robDavidJuiceMan', 'My office for day.'),
          ],
        ));
  }
}