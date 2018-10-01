import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Notes',
      home: const MyHomePage(title: 'Meeting Notes'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SmartShare',
        home: NewButton()
    );
  }
}

class NewButtonState extends State<NewButton> {
  Widget dbOut = new Text('');
  var counter = 0;
  List<String> team = new List();
  @override
  Widget build(BuildContext context) {
    team.add("Suchitra");
    team.add("Gomathy");
    team.add("Jenny");
    team.add("Anusha");
    team.add("Asmita");

    return Scaffold (
        appBar: AppBar(title: Text('Smart Share'),),
        body: new Column(
            children: <Widget>[
              new FloatingActionButton(
                child: new Text('Notes'),
                onPressed: () { setState(() {
                  String selected = team[counter];
                  dbOut = refreshFeed(selected);
                  counter = counter + 1;
                }); },
              ),
              Flexible(child: dbOut),
            ]));
  }
  Widget refreshFeed(String selected) {
    return new StreamBuilder(
        stream: Firestore.instance.collection('notes').where('User', isEqualTo: selected).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Now Loading...');
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemExtent: 25.0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return new Text("Title: ${ds['Name']}\n\n\nUser: ${ds['User']}\n\n${ds['Body']} \n\nDate: ${ds['Date']}");
              }
          );
        });
  }
  Widget refreshEntireFeed() {
    return new StreamBuilder(
        stream: Firestore.instance.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Now Loading...');
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemExtent: 25.0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return new Text("Title: ${ds['Name']}\n\n\nUser: ${ds['User']}\n\n${ds['Body']} \n\nDate: ${ds['Date']}");
              }
          );
        });
  }


}

class NewButton extends StatefulWidget {
  @override
  NewButtonState createState() => new NewButtonState();
}
