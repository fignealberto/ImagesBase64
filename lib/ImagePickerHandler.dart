import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'ImagePickerDialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final int maxWidthInitialProfileImage = 500;
final int maxHeightInitialProfileImage = 500;

class ImagePickerHandler {
  ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;
  bool thereIsImage;

  ImagePickerHandler(this._listener, this._controller, this.thereIsImage);

  openCamera() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    cropImage(image);
  }

  openGallery() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    cropImage(image);
  }

  void init() {
    imagePicker = ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  Future cropImage(File image) async {
    File croppedFile;
    bool updateImage = false;

    if(image != null){
      croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxWidth: maxWidthInitialProfileImage,
        maxHeight: maxHeightInitialProfileImage,
      );
      print('cropImage');
      updateImage = true;
    }

    _listener.userImage(croppedFile, updateImage);
  }

  showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }

  deleteImage(){
    _listener.userImage(null, true);
  }
}

abstract class ImagePickerListener {
  userImage(File image, bool updateImage);
}