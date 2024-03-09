import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantProductProvider with ChangeNotifier{
  void addProduct({
    required BuildContext context,
    String? productName,
    File? productImage,
    String? productPrice,
    String? productDesc,
    VoidCallback? onSuccess,
    Function(dynamic)? onError,
  }) async {
    try{
      String imageUrl = await uploadImageToFirebase(productImage!) as String;
      String documentId = DateTime.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance
          .collection("FoodProducts")
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set({
        "prodcutCode": productName,
        "productName": productName,
        "productImage": imageUrl,
        "productDescription": productDesc,
        "productId": documentId,
        "productPrice": productPrice,
        "restaurantId": FirebaseAuth.instance.currentUser?.uid
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product added successfully'),
        ));
        if (onSuccess != null) onSuccess(); // Call success callback
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add product: $error'),
        ));
        if (onError != null) onError(error); // Call error callback
      });
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add product: $e'),
      ));
    }
  }

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      // Convert XFile to File
      File file = File(imageFile.path);

      // Create a reference to the location you want to upload to in Firebase Storage
      Reference storageReference = FirebaseStorage.instance.ref().child('FoodImages').child(DateTime.now().millisecondsSinceEpoch.toString());

      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(file);

      // Await the completion of the upload task
      await uploadTask;

      // Get the download URL for the image
      String imageUrl = await storageReference.getDownloadURL();

      // Return the download URL
      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}