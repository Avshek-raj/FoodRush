import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RestaurantProductProvider with ChangeNotifier{
  late RestaurantProvider restaurantProvider;
  void addProduct({
    required BuildContext context,
    String? productName,
    File? productImage,
    String? productPrice,
    String? productDesc,
    String? category,
    VoidCallback? onSuccess,
    Function(dynamic)? onError,
  }) async {
    try{
      restaurantProvider = Provider.of(context, listen:false);
      String imageUrl = await uploadImageToFirebase(productImage!) as String;
      String documentId = DateTime.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance
          .collection("FoodProducts")
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set({
        "productCode": productName?.toLowerCase(),
        "productName": productName,
        "category": category,
        "productImage": imageUrl,
        "productDescription": productDesc,
        "productId": documentId,
        "productPrice": productPrice,
        "restaurantId": FirebaseAuth.instance.currentUser?.uid,
        "restaurantName": restaurantProvider.restaurantModel.restaurantName,
        "RestaurantLatLng":restaurantProvider.restaurantModel.restaurantLatLng,
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
  //update product
 void editProduct({
  required BuildContext context,
  required String productId,
  String? productName,
  File? productImage,
  String? productPrice,
  String? productDesc,
  String? category,
  VoidCallback? onSuccess,
  Function(dynamic)? onError,
}) async {
  try {
    restaurantProvider = Provider.of(context, listen: false);

    // If a new image is provided, upload it to Firebase Storage
    String imageUrl = '';
    if (productImage != null) {
      imageUrl = await uploadImageToFirebase(productImage) as String;
    }

    // Update the document with the edited product data
    await FirebaseFirestore.instance
        .collection("FoodProducts")
        .doc(productId)
        .update({
      "productName": productName,
      "category": category,
      "productImage": imageUrl.isNotEmpty ? imageUrl : null,
      "productDescription": productDesc,
      "productPrice": productPrice,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Product edited successfully'),
      ));
      if (onSuccess != null) onSuccess(); // Call success callback
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to edit product: $error'),
      ));
      if (onError != null) onError(error); // Call error callback
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to edit product: $e'),
    ));
  }
}


  //for delete

  Future<void> deleteProductFromFirestore(String productId,
      {required VoidCallback onSuccess, required Function(dynamic) onError}) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference products =
          FirebaseFirestore.instance.collection('FoodProducts');

      // Delete the document from Firestore based on the product name
      await products.doc(productId).delete();

      // If successful, call the success callback
      onSuccess();
    } catch (e) {
      // If an error occurs, call the error callback with the error
      onError(e);
    }
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
