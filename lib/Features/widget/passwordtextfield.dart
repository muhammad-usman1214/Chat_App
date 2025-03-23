import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget  passwordTextField({
  required String hintT,
  required String labelT,
  required IconData prefixIcon,
  required IconData suffixIcon,
  required TextEditingController controller,
  required TextInputType keyType,
  required BuildContext context,
  required bool obSecure,
required VoidCallback onPressed,
required ValueNotifier notifier}){

  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width*1,
    decoration: BoxDecoration(
      //borderRadius: BorderRadius.all(10 as Radius),
      color: Colors.grey,
    ),
    child: ValueListenableBuilder(
      valueListenable: notifier,
      builder: (ctx,value,child){
        return TextFormField(
          controller: controller,
          keyboardType: keyType,
          obscureText: obSecure,
          decoration: InputDecoration(
            hintText: hintT,
            labelText: labelT,
            prefixIcon: Icon(prefixIcon),
            suffixIcon: InkWell(
              onTap: onPressed,),
          ),
        );
      },
    ),
  );

}