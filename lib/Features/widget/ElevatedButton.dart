
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget elevatedButtonWidget({
  required VoidCallback onPressed,
  required String title,

}){
  return Container(
    width: 250,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.black,

    ),
    child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title,style: TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.w500),)),


  );

}