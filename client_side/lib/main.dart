import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = List();
  var bodyContent;

  _fetchData() async {
    print("Fetch called");
    const url = 'http://localhost:8888/words';
    final header = {'Content-Type': 'application/json'};
    final res = await http.get(url);

    if (res.statusCode == 200) {
      list = json.decode(res.body) as List;
      // var body = json.decode(res.body);
      // for(int i =0; i< body.length; i++){
      // bodyContent = body[i]["content"];
      // print(bodyContent);
      // }
      // final content = body["content"];

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.refresh),
          onPressed: () {
            setState(() {});
            _fetchData();
            print("Something Reloading");
          },
        )
      ]),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(list[index]['word']),
                    subtitle: new Text(list[index]["content"]["description"]),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(25.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Enter your words'),
                onSubmitted: (input){
                  print(input);
                } ,
              ),
            )
          ],
        ),
      ),
    );
  }
}
