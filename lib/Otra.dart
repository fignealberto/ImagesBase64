import 'package:flutter/material.dart';

class Otra extends StatefulWidget {
  @override
  _OtraState createState() => _OtraState();
}

class _OtraState extends State<Otra> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Título'),
        ),
        body: Container(
          child: RaisedButton(
              onPressed: () {_showDialog('Título', 'Texto');},
              child: Text('clic'),
          ),
        ),
      ),
    );
  }

  void _showDialog(String title, String text) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //title: Text(title),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
