import 'dart:async';

import 'package:flutter/material.dart';
import 'ImagePickerHandler.dart';

class ImagePickerDialog extends StatelessWidget {

  ImagePickerHandler _listener;
  AnimationController _controller;
  BuildContext context;

  ImagePickerDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  final EdgeInsets _margin = EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0);
  final Color _bgColor = Color(0xff5B3566);
  final Color _textColor = Color(0xffffffff);

  void initState() {
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => SlideTransition(
        position: _drawerDetailsPosition,
        child: FadeTransition(
          opacity: ReverseAnimation(_drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = Duration(milliseconds: 200);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Material(
        type: MaterialType.transparency,
        child: Opacity(
          opacity: 1.0,
          child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: _getOptions(),
            ),
          ),
        ));
  }

  List<Widget> _getOptions(){
    List<Widget> list = [];

    list.add(
        GestureDetector(
            onTap: () => _listener.openCamera(),
            child: roundedButton('Camera')
        )
    );
    list.add(
        GestureDetector(
            onTap: () => _listener.openGallery(),
            child: roundedButton('Gallery')
        )
    );
    if((_listener.thereIsImage ?? false)){
      list.add(const SizedBox(height: 15.0));
      list.add(
          GestureDetector(
              onTap: _removeImage,
              child: roundedButton('Delete current')
          )
      );
    }
    list.add(const SizedBox(height: 15.0));
    list.add(
        GestureDetector(
          onTap: () => dismissDialog(),
          child: roundedButton('Cancel'),
        )
    );

    return list;
  }

  Widget roundedButton(String buttonLabel) {
    var loginBtn = Container(
      margin: _margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.all(const Radius.circular(0.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
            color: _textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

  void _removeImage(){
    dismissDialog();
    _listener.deleteImage();
  }
}