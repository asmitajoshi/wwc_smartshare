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
  Widget dbOut = new Text('askjd');
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(title: Text('Smart Share'),),
        body: new Column(
            children: <Widget>[
              new FloatingActionButton(
                child: new Text('Click'),
                onPressed: () { setState(() => (dbOut = refreshFeed())); },
              ),
              Flexible(child: dbOut),
            ]));
  }

  Widget refreshFeed() {
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
                String users = 'TODO subdir parse and array';
                return new Text(" ${ds['Name']} ${ds['Body']} ${ds['Date']} $users");
              }
          );
        });
  }


}

class NewButton extends StatefulWidget {
  @override
  NewButtonState createState() => new NewButtonState();
}
