import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../authservices/authservices.dart';
import '../chatServices/chatservices.dart';

class Chat_Page extends StatefulWidget {
  final String receiverusername;
  final String receiverID;
  final String Base64url;
  Chat_Page({
    required this.receiverusername,
    required this.receiverID,
    required this.Base64url ,
});

  @override
  State<Chat_Page> createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {
   TextEditingController _messageController=TextEditingController();

  final chatServices _chatservices=chatServices();

  final AuthServices _authservices=AuthServices();

  // send funcation
  void sendmessage() async{
    await _chatservices.sendMessage(widget.receiverID, _messageController.text);
    _messageController.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Flexible( // Ensures the title doesn't push leading items
          child: Text(widget.receiverusername, overflow: TextOverflow.ellipsis),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions:[Padding(padding: EdgeInsets.only(right: 10),
        child:  widget.Base64url == null || widget.Base64url.isEmpty || widget.Base64url == ''
            ? CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Icon(Icons.account_circle, size: 40, color: Colors.grey),
        )
            : CircleAvatar(
          radius: 24,
          backgroundImage: MemoryImage(base64Decode(base64.normalize(widget.Base64url))),
        ),)]

      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(
          children: [
           Expanded(
               child: buildMessageList()),

               buildUserInput(),

          ],

        ),
      ),
    );
  }

  @override
  Widget buildMessageList() {
    String senderID=_authservices.getcurrentuser()!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: _chatservices.getMessages(widget.receiverID, senderID),
        builder: (context ,snapshot){
          print("Snapshot Connection State: ${snapshot.connectionState}");
          if(snapshot.hasError){
            return Text('Error');
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Text('Loading');

          }

          // Print fetched messages
          print("Snapshot Data: ${snapshot.data?.docs.map((doc) => doc.data()).toList()}");


          return ListView(
            reverse: true,
            children: snapshot.data!.docs.map((doc) {
              print("Message Data: ${doc.data()}");
              return buildMessageItem(doc);
            }).toList()
               // Debugging message data
          );
        });

  }

  //Message Item
  @override
  Widget buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data=doc.data() as Map<String,dynamic>;

    // if (!data.containsKey('message')) {
    //   print("Error: Message field is missing in Firestore document.");
    //   return Container();
    // }


    //Is current User
    bool isCurrentUser=data['SenderID']==_authservices.getcurrentuser()!.uid;
    //Align right side if user is currentUser othervise left
    var alignment=isCurrentUser?Alignment.centerRight:Alignment.centerLeft;
    print( 'Message data:${data['Message']}');

    return  Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.greenAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: isCurrentUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text(
              data['Message'] ?? 'hello',
              style: TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );


  }

  //Input field
  @override
  Widget buildUserInput(){
    return Row(
      children: [
        Expanded(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey
              ),
              child: TextFormField(
                controller: _messageController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Type Message here..',
                  border: InputBorder.none,

                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green

            ),
            child: IconButton(
              color: Colors.white,
                onPressed: (){
              sendmessage();
            },
                icon: Icon(Icons.send_rounded)),
          ),
        )

      ],
    );
  }
}
