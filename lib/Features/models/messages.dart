import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderemail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;
  Message({
   required this.senderemail,
    required this.senderId,
    required this.receiverID,
    required this.message,
    required this.timestamp

});

  Map<String, dynamic> toMap(){
    return{
      'SenderID':senderId,
      'SenderEmail':senderemail,
      'ReceiverID':receiverID,
      'Message':message,
      'Timestamp':timestamp,
    };
  }
}