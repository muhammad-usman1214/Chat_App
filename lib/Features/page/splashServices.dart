import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_chart/Features/page/Login_page.dart';
import 'HomeScreen.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
      Timer(const Duration(seconds: 3),
              ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Scrren()))
      );

    }else{
      Timer(const Duration(seconds: 3),
              ()=>
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Sceen()))
      );
    }
  }
}