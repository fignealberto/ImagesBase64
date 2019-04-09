import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'Settings.dart';

Future<Uint8List> base64ToMemoryImage(String strBase64) async {
  return base64.decode(strBase64);
}

Future<String> imageToString(File image) async{
  Uint8List bytes = image.readAsBytesSync();
  return base64.encode(bytes);
}

Future<String> imageFromPathToString(String path) async{
  return imageToString(File(path));
}

Future<File> pickImage(double maxWidth, double maxHeight, ImageSource source) async {
  if(maxWidth > 0  && maxHeight > 0){
    return await ImagePicker.pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
  } else if(maxWidth > 0){
    return await ImagePicker.pickImage(
      source: source,
      maxWidth: maxWidth,
    );
  } else if(maxHeight > 0){
    return await ImagePicker.pickImage(
      source: source,
      maxHeight: maxHeight,
    );
  } else {
    return await ImagePicker.pickImage(
      source: source,
    );
  }
}

Future<String> saveBase64AsImage(String strBase64, String fileName) async {
  Uint8List bytes = base64.decode(strBase64);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File('$dir/$fileName');
  await file.writeAsBytes(bytes);
  return file.path;
}

Future<void> deleteFile(String path) async {
  try {
    File(path).delete();
  } catch (e) {
    print("deleteFile: $e");
  }
}

Future<ImageProvider> getImageProvider(String strBase64) async {
  if((strBase64 ?? '') != ''){
    Uint8List bytes = await base64ToMemoryImage(strBase64);

    if((bytes?.length ?? 0) > 0){
      return MemoryImage(bytes);
    }
  }

  return defaultUserImageProvider();
}


ImageProvider defaultUserImageProvider(){
  return AssetImage(profileDefaultImage);
}

/*
//para obtener dimensiones de una imagen
decodeImageFromList(image.readAsBytesSync()).then((i){
print('Image: width=${i.width}, height=${i.height}');
});
*/
