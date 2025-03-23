import 'dart:convert';

import 'package:flutter/material.dart';

class Usertile extends StatelessWidget {
  final String text;
  final String lastMsg;
  final String timestamp;
  final String profileImg;
  final void Function()? onTape;
  Usertile({
    required this.text,
    required this.onTape,
    required this.lastMsg,
    required this.timestamp,
    required this.profileImg
});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: GestureDetector(
        onTap: onTape,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height*74/812,
          width: MediaQuery.of(context).size.width*375/375,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.white70,
                  spreadRadius: 0.0,
                  blurRadius: 15
              )
            ],
            border: Border(
              bottom: BorderSide(
                color: Colors.blueGrey,
                width: 0.1,
              )
            )

          ),
            child: ListTile(
              leading: profileImg==null||profileImg.isEmpty||profileImg==''?
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.account_circle, size: 40, color: Colors.grey),
              )
              :CircleAvatar(
                radius: 24,
                backgroundImage: MemoryImage(base64Decode(profileImg)),
              ),
              title: Text(text),
              subtitle: Text(lastMsg),
              trailing: Text(timestamp),
            ),

        ),
      ),
    );
  }
}
