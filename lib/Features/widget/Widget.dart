import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../authservices/authservices.dart';
import '../chatServices/chatservices.dart';
import '../funcation/sendmessage.dart';
final chatServices _chatservices=chatServices();
final AuthServices _authservices=AuthServices();
TextEditingController _messageController=TextEditingController();

Widget buildMessageList( final String receiveremail){
  String senderID=_authservices.getcurrentuser()!.uid;
  return StreamBuilder<QuerySnapshot>(
      stream: _chatservices.getMessages(receiveremail, senderID),
      builder: (context ,snapshot){
        print("Snapshot Connection State: ${snapshot.connectionState}");
        if(snapshot.hasError){
          return Text('Error');
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Text('Loading');

        }
        // Debugging: Print snapshot data
        // Print received messages for debugging
        print("Snapshot Data: ${snapshot.data!.docs.length} messages received");
        for (var doc in snapshot.data!.docs) {
          print("Message Document Data: ${doc.data()}");
        }

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
Widget buildMessageItem(DocumentSnapshot doc){
  Map<String,dynamic> data=doc.data() as Map<String,dynamic>;

  if (!data.containsKey('message')) {
    print("Error: Message field is missing in Firestore document.");
    return Container();
  }


  //Is current User
  bool isCurrentUser=data['SenderID']==_authservices.getcurrentuser()!.uid;
  //Align right side if user is currentUser othervise left
  var alignment=isCurrentUser?Alignment.centerRight:Alignment.centerLeft;
  print(data['Message']);

  return  Align(
    alignment: alignment,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        data['Message'] ?? 'hello',
        style: TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
      ),
    ),
  );


}
//Input field
Widget buildUserInput(  String receiverEmail){
  return Row(
    children: [
      Expanded(
          child: TextFormField(
            controller: _messageController,
            obscureText: false,
            decoration: InputDecoration(
                hintText: 'Type Message here..'
            ),
          )),
      IconButton(onPressed: (){
        sendmessage(receiverEmail);
      },
          icon: Icon(Icons.send_rounded))

    ],
  );
}