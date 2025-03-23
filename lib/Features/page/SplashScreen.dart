import 'package:flutter/material.dart';
import 'package:group_chart/Features/page/splashServices.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  SplashServices splashscreen=SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.isLogin(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(
          vertical: 10,horizontal: 20),
      child: Center(child: Text('Firebase Options'),),),
    );
  }
}
