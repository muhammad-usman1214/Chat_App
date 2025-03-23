import 'dart:convert';
import 'package:flutter/material.dart';
class Custom_Drawer extends StatefulWidget {
  String username;
  String userEmail;
  Function Logout;
  String imageUrl;
  Function uploadImage;
  Function fetchImage;
  Custom_Drawer({required this.username,required this.userEmail,required this.fetchImage,required this.uploadImage,required this.Logout,required this.imageUrl});

  @override
  State<Custom_Drawer> createState() => _Custom_DrawerState();
}

class _Custom_DrawerState extends State<Custom_Drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildHeader(context, widget.username, widget.userEmail,widget.imageUrl,),
          buildMenuItem(context, widget.Logout),
        ],
      ),
    ));
  }
  Widget buildHeader(BuildContext context,String name,String email,String imageUrl) =>Container(
    color:  Colors.greenAccent,
    width: double.infinity,
    padding: EdgeInsets.only(
        top: 24+MediaQuery.of(context).padding.top,
        bottom: 24
    ),
    child: Column(
      children: [
        Stack(

          children: [
            imageUrl == null
                ? CircularProgressIndicator() // Show loader if image is not loaded yet
                : (imageUrl == 'no image'
                ? Icon(Icons.account_circle, size: 80) // Show default icon
                : CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(base64Decode(base64.normalize(imageUrl))),
            )),
            Positioned
              (
              bottom: -10,
              left: 60,
              child: IconButton(
                  onPressed: () async{
                    await widget.uploadImage();
                    setState(() {}); // Refresh UI after upload
                  }, icon: Icon(Icons.add_a_photo_outlined)),)
          ],
        ),

        SizedBox(height: 12,),
        Text(name),
        Text(email),
        ElevatedButton(
            onPressed: ()async {
             await widget.fetchImage();
             setState(() {

             });
            },
            child: Text('Edit Profile'))


      ],
    ),
  );
}
Widget buildMenuItem(BuildContext context ,Function logout) {
  return Wrap(
    runSpacing: 16,
      children: [
        ListTile(
          leading: Icon(Icons.home_filled),
          title: Text('H o m e'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('A B O U T'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('S E T T I N G'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.favorite_border),
          title: Text('F A V O U R I T E'),
          onTap: () {},
        ),
        SizedBox(height: 40,),
        Container(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: (){
                logout(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LogOut',style: TextStyle(fontSize: 18,color: Colors.redAccent),),
                  SizedBox(width: 5,),
                  Icon(Icons.logout,color: Colors.redAccent,)
                ],
              )),
        )
      ],

  );
}