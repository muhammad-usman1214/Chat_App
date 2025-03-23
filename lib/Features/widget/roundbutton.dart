import 'package:flutter/material.dart';

class RoundButton2 extends StatelessWidget{
  final String title;
  final VoidCallback onTap;
  RoundButton2({required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(child: Text(title)),
      ),
    );
  }


}

