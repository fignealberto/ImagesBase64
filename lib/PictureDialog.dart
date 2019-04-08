import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PictureDialog extends StatelessWidget {
  final String text;

  PictureDialog({this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: <Widget>[
        FlatButton(
          child: Text('Cámara'),
          onPressed: () {Navigator.of(context).pop(ImageSource.camera);},
        ),
        FlatButton(
          child: Text('Galería'),
          onPressed: () {Navigator.of(context).pop(ImageSource.gallery);},
        )
      ],
    );
  }
}