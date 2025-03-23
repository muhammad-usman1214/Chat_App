import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_chart/Features/page/Login_page.dart';
import 'package:group_chart/Features/components/toastmsg.dart';
import 'package:group_chart/Features/authservices/authservices.dart';
import 'package:group_chart/Features/chatServices/chatservices.dart';
import 'package:group_chart/Features/page/chatpage.dart';
import 'package:group_chart/Features/page/drawer.dart';
import 'package:group_chart/Features/page/message.dart';
import 'package:intl/intl.dart';

import '../components/Usertile.dart';
import '../models/Imagepicker.dart';
class Home_Scrren extends StatefulWidget {
  const Home_Scrren({super.key});

  @override
  State<Home_Scrren> createState() => _Home_ScrrenState();
}

class _Home_ScrrenState extends State<Home_Scrren> {
  final chatServices _chatservices=chatServices();
  final AuthServices _authservices=AuthServices();
  String? Base64url;

  Future<void> fetchimage() async {
    String? fetchedImage = await _authservices.getUserProfileImage();
    if (fetchedImage != null && fetchedImage.isNotEmpty) {
      setState(() {
        Base64url = base64.normalize(fetchedImage); // Normalize before decoding
      });
    } else {
      print("No image found");
    }
  }

  Future<void> uploadimage() async {
    String? newImage = await _authservices.pickAndUploadImage();
    if (newImage != null) {
      setState(() {
        Base64url = newImage;  // Update UI after image upload
      });
    }
  }


  void logout(BuildContext context)async{
    final authservices=AuthServices();
    try{
      await authservices.SignOut().then((value){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Sceen()));
      });
    }catch(e){
      Utils.ToastMsg('Error');
    }

  }
  String username = "Loading...";
  String useremail = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUsername();
    fetchimage();
    uploadimage();
  }

  Future<void> fetchUsername() async {
    String uid = _authservices.getcurrentuser()!.uid;
    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();

    setState(() {
      username = userDoc['username']; // Get the username from Firestore
      useremail = userDoc['email'];
    });
    print("Username: $username");
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Chat Box'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          actions: [
            IconButton(onPressed: (){
            }, icon: Icon(Icons.more_vert))
          ],

      ),
      drawer: Custom_Drawer(username: username,userEmail: useremail,Logout:logout,imageUrl: Base64url??'',uploadImage: uploadimage,fetchImage:fetchimage ,),
      body:_builduserlist(),

    );
  }

  Widget _builduserlist(){
    return StreamBuilder(
        stream: _chatservices.getUserStream() ,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Text('error');
          }
          //Loading
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text('Loading');

          }

          return ListView(
            children: snapshot.data!.map<Widget>((userData)=>buildUserItem(userData, context)).toList(),

          );


        },
    );

  }
  // UserListItem
 Widget buildUserItem(Map<String, dynamic> userData,BuildContext context){
    String email =userData['email']??'no Email Available';
    String uid =userData["uid"]??'no Uid Available';
    String username =userData["username"]??'no Uid Available';
    Timestamp? timestamp =userData["createdAt"]??'10:23';
    String formattedTime = "N/A";  // Default value

    if (timestamp != null) {
      DateTime dateTime = timestamp.toDate();  // Convert to DateTime
      formattedTime = DateFormat.jm().format(dateTime);  // Format as "10:45 AM"
    }
    String profileImg =userData["imageData"]??'';

        if(userData['email'] !=_authservices.getcurrentuser()?.email) {
      return Usertile(
        text: username,
        lastMsg: email,
        profileImg: profileImg,
        timestamp: formattedTime,
        onTape: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat_Page(
                    receiverusername: username,
                    receiverID: uid,
                    Base64url:profileImg ,
                      )));
        },
      );
    }else{
    return Container(
    );
  }
  }
}

