import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../authservices/authservices.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  final AuthServices _authservices=AuthServices();

  Future<String?> pickAndUploadImage() async {
    try {
      // Pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      File file = File(image.path);
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Upload to Firebase Storage
      UploadTask uploadTask =
      FirebaseStorage.instance.ref().child(fileName).putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      String uid=_authservices.getcurrentuser()!.uid;
      // Store in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
          {
            'ImgUrl':imageUrl,
            'timestamp': FieldValue.serverTimestamp(),
          });

      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }
}
