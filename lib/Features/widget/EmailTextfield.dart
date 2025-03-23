import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget  emailTextField({
  required String hintText,
  required IconData prefixIcon,
  required TextEditingController controller,
   required TextInputType keyType,
  required BuildContext context,
   }){

  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width*1,
    decoration: BoxDecoration(
      //borderRadius: BorderRadius.all(),
      color: Colors.grey.shade300,
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: keyType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
          border: InputBorder.none,
          prefixIcon: Icon(prefixIcon),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter an email';
        }
        if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value.trim())) {
          return 'Enter a valid email address';
        }
        return null;
      },
    ),
  );

}