import 'dart:io';
import 'package:flutter/material.dart';

import 'ImagePickerHandler.dart';

final int maxWidthFinalProfileImage = 100;
final int maxHeightFinalProfileImage = 100;


class PickAndCrop2 extends StatefulWidget {
  @override
  _PickAndCrop2State createState() => _PickAndCrop2State();
}

class _PickAndCrop2State extends State<PickAndCrop2>
    with TickerProviderStateMixin, ImagePickerListener {

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState(){
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ImagePickerHandler(this, _controller, _image != null);
    imagePicker.init();
    print('init');

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print('_image is null: ${_image == null}');

    return Scaffold(
      appBar: AppBar(title: Text('Pick and crop 2'),),
      body: Column(
        children: <Widget>[
          Text('holi'),
          GestureDetector(
            onTap: () => imagePicker.showDialog(context),
            child: Center(
              child: _image == null
                  ? Stack(
                children: <Widget>[

                  Center(
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundColor: const Color(0xFF778899),
                    ),
                  ),
                  Center(
                    child: new Image.asset("images/photo_camera.png"),
                  ),

                ],
              )
                  : Container(
                height: 160.0,
                width: 160.0,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: ExactAssetImage(_image.path),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                  BorderRadius.all(const Radius.circular(80.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  userImage(File image, bool updateImage) {
    if(updateImage){

      if(image != null){
        decodeImageFromList(image.readAsBytesSync()).then((i){
          print('Image: width=${i.width}, height=${i.height}');
        });
      }

      setState(() {
        _image = image;
        imagePicker.thereIsImage = _image != null;
      });
    }
  }
}
