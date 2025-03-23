import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class Utils{
  static ToastMsg(String msg){
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}