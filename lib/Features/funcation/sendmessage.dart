import 'package:flutter/material.dart';

import '../authservices/authservices.dart';
import '../chatServices/chatservices.dart';

final chatServices _chatservices=chatServices();
final AuthServices _authservices=AuthServices();
TextEditingController _messageController=TextEditingController();

void sendmessage(String receiveremail) async{
  await _chatservices.sendMessage(receiveremail, _messageController.text);
  _messageController.clear();

}