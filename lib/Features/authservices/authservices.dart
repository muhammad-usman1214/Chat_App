import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AuthServices{
  //Instance of Auth
  FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  //get current user
  User? getcurrentuser(){
    return _auth.currentUser;
  }
  //sign In
 Future<UserCredential> loginWithEmailandPassword(String email,password) async{
   try{
    UserCredential usercredenial = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return usercredenial;
   }on FirebaseException catch(e){
     throw Exception(e.code);
   }
 }


  //SignUP
  Future<UserCredential> signUpwithEmailandPassword(String email,String password,String username,String phoneNumber ) async{

   //create user if user is new
    try{
      UserCredential usercredenial = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
           );
      //save user information
      _firestore.collection('users').doc(usercredenial.user!.uid).set(
        {
          'uid': usercredenial.user!.uid,
          'email':email,
          'username': username,
          'phoneNumber': phoneNumber,  // ✅ Save Phone Number
           'imageData':null,
          'createdAt': FieldValue.serverTimestamp(), // ✅ Timestamp
        }
      );
      return usercredenial;

    }on FirebaseException catch(e){
      throw Exception(e.code);
    }
  }
  // Pick Image and Upload to Firestore
  Future<String?> pickAndUploadImage() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("No user logged in.");
      }

      // Pick an image from the gallery
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      // Convert image to base64
      File file = File(image.path);
      List<int> imageBytes = await file.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Store base64 image string in Firestore under the user's document
      await _firestore.collection('users').doc(user.uid).update({
        'imageData': base64Image,
      });

      return base64Image; // Return the base64 image string to update UI

    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // Get User Profile Image
  Future<String?> getUserProfileImage() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return null;
      }

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists && userDoc['imageData'] != null) {
        return userDoc['imageData'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching image: $e");
      return null;
    }
  }



  //sign out
  Future<void> SignOut()async{
   return await _auth.signOut();
  }
}