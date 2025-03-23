import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget headerWidget({required String title,
  required BuildContext context}){
  return Column(
    children: [
      SizedBox(height: 10,),
      Container(
        child:Text(title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black),),
      ),
      SizedBox(height: 10,),
      Divider(thickness: 1,)
    ],
  );
}