import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/messages.dart';

class chatServices{
  //create firebase Instance
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;



  //get user stream
  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection('users').snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        final user=doc.data();
        return user;
      }).toList();
    });
  }

  //sender message
  Future<void> sendMessage(String receiverId,message) async{
    final currentUserId=_auth.currentUser!.uid;
    final currentUserEmail=_auth.currentUser!.email!;
    final timestamp=Timestamp.now();
    Message newmessage=Message(
      senderId: currentUserId,
      senderemail: currentUserEmail,
      receiverID: receiverId,
      message: message,
      timestamp: timestamp,
    );
    //construct chat room id for two peoples
    List<String> ids=[currentUserId,receiverId];
    ids.sort();
    String chatRoomID=ids.join('_');
    print("Saving message to Chat Room: $chatRoomID");
    // Add two messages in Database
    await _firestore
        .collection('chat_Rooms')
        .doc(chatRoomID)
        .collection('Messages')
        .add(newmessage.toMap());
    print("Message sent successfully: ${newmessage.message}");


  }


  //get message
   Stream<QuerySnapshot> getMessages(String userID,String otherUserID){
    List<String> ids=[userID,otherUserID];
    ids.sort();
    String chatRoomID=ids.join('_');
    print("Fetching messages for Chat Room: $chatRoomID");
    return _firestore
        .collection('chat_Rooms')
        .doc(chatRoomID)
        .collection('Messages')
        .orderBy('Timestamp',descending: true)
        .snapshots()
        .handleError((error) {
      print("Error fetching messages: $error");
    });
   }
}