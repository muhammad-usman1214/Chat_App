import 'package:flutter/material.dart';

import '../widget/Widget.dart';

class Message_show extends StatelessWidget {
  final String receiveremail;
  Message_show({
    required this.receiveremail
});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Message'),
      ),
      body: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Column(
        children: [
          buildMessageList(receiveremail),
        ],
      ),),
    );
  }
}
