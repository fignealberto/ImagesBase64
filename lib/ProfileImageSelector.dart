import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'Colors.dart';
import 'Settings.dart';

final double profileImageRadio = 60.0;
final double iconSize = 30.0;

class ProfileImageSelector extends StatelessWidget {
  final ProfileImageSelectorListener listener;
  final ImageProvider imageProvider;
  final bool thereIsImage;

  ProfileImageSelector({this.listener, this.imageProvider, this.thereIsImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            IconButton(
              onPressed: () { _lookForImage(ImageSource.camera); },
              icon: Icon(Icons.photo_camera, size: iconSize,),
            ),
            IconButton(
              onPressed: () { _lookForImage(ImageSource.gallery); },
              icon: Icon(Icons.photo_library, size: iconSize,),
            ),
            IconButton(
              onPressed: thereIsImage ? _delete : null,
              icon: Icon(Icons.delete, size: iconSize,),
            ),
          ],
        ),
        Container(
          width: profileImageRadio * 2,
          height: profileImageRadio * 2,
          decoration: BoxDecoration(
            //color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            border: Border.all(
                color: Colors.black,
                width: 1.0,
                style: BorderStyle.solid
            ),
            borderRadius:
            BorderRadius.all(Radius.circular(profileImageRadio)),
          ),
        )
      ],
    );
  }

  void _lookForImage(ImageSource source) async {
    File image;
    File croppedFile;
    bool update = false;

    image = await ImagePicker.pickImage(
      source: source,
      maxWidth: maxWidthInitialProfileImage.toDouble(),
      maxHeight: maxHeightInitialProfileImage.toDouble(),
    );

    if(image != null){
      croppedFile = await ImageCropper.cropImage(
        toolbarTitle: cropPageToolbarTitle,
        toolbarColor: primaryColor,
        circleShape: true,
        sourcePath: image.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxWidth: maxWidthFinalProfileImage,
        maxHeight: maxWidthFinalProfileImage,
      );

      if(croppedFile != null){
        update = true;
      }
    }

    if(update){
      listener.updateFunction(croppedFile);
    }
  }

  void _delete(){
    listener.delete();
  }

}


abstract class ProfileImageSelectorListener {
  updateFunction(File image);
  delete();
}
