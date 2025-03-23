import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Features/page/Login_page.dart';

class ongenerateRoutes{

  static Route<dynamic> route(RouteSettings settings){
    final args=settings.arguments;
    switch(settings.name){
      case '/':{
        return materialRouteBuilder(widget:Login_Sceen() );
      }
      default:return materialRouteBuilder(widget:Error_Page() );
    }

  }
}
MaterialPageRoute materialRouteBuilder({required Widget widget}){
  return MaterialPageRoute(builder: (context)=>widget);
}
// by default error Page
class Error_Page extends StatelessWidget {
  const Error_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Error Page'),
      ),
      body: Center(
        child: Text('Error Page'),
      ),
    );
  }
}
