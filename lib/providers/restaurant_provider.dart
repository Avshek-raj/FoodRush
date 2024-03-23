import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantModel {
  String? restaurantName;
  String? email;
  String? address;
  String? phone;
  String? password;
  String? about;
  XFile? restaurantImage;
  String? restaurantImageLink;
  String? token;
  String? restaurantLatLng;
  String? role;
  RestaurantModel({this.role, this.restaurantLatLng, this.restaurantName,this.email,this.address,this.phone,this.password, this.about, this.restaurantImage, this.token, this.restaurantImageLink});
}

class RestaurantProvider with ChangeNotifier {
  void addRestaurantDetails({
    required BuildContext context,
    String? restaurantName,
    String? email,
    String? phone,
    String? address,
    LatLng? restaurantLatLng,
    String? password,
    String? about,
    File? restaurantImage,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      String imageUrl = await uploadImageToFirebase(restaurantImage!) as String;
      await FirebaseFirestore.instance
          .collection("RestaurantUsers")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("RestaurantInfo")
          .doc("Details")
          .set({
        "RestaurantId": FirebaseAuth.instance.currentUser?.uid,
        "RestaurantName": restaurantName,
        "Email": email,
        "Phone": phone,
        "RestaurantLatLng": restaurantLatLng.toString(),
        "Address": address,
        "Password": password,
        "About": about,
        "Role": "Restaurant",
        "RestaurantImage" : imageUrl
      }).then((_) {
        print('Restaurant info uploaded Successfully');
        if (onSuccess != null) onSuccess();
      }).catchError((error) {
        print('Error:Error on restaurant info upload');
        if (onError != null) onError(error); 
      });
    } catch (e) {
      print('Error:Error on restaurant info upload');
      if (onError != null) onError(e);
    }
  }

  List<RestaurantModel> restaurantInfoList = [];
  late RestaurantModel restaurantModel ;
  fetchRestaurantDetails(userId,callback) async {
    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (userId != ""){
        uid = userId;
      }
      List<RestaurantModel> newList = [];
      QuerySnapshot value = await FirebaseFirestore.instance
          .collection("RestaurantUsers")
          .doc(uid)
          .collection("RestaurantInfo")
          .get();
      value.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        bool deliveryInfo = data.containsKey("Name");
         if (data.containsKey("Token")){
          token = data["Token"];
        } else {
          restaurantModel = RestaurantModel(
            restaurantName: data["RestaurantName"],
            email: data["Email"],
            address: data["Address"],
            phone: data['phone'],
            password: data["Password"],
            about: data["About"],
            restaurantImageLink:data["RestaurantImage"],
            restaurantLatLng: data["RestaurantLatLng"],
            role: data["Role"],
          );
        }
      });
      restaurantInfoList = newList;
    }catch (e){
      print(e);
    }
    callback();
    notifyListeners();
  }

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      // Convert XFile to File
      File file = File(imageFile.path);

      // Create a reference to the location you want to upload to in Firebase Storage
      Reference storageReference = FirebaseStorage.instance.ref().child('RestaurantImages').child(DateTime.now().millisecondsSinceEpoch.toString());

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

  String token = "";
  void fetchRestaurantToken(String restaurantId, {
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
          .collection("RestaurantUsers")
          .doc(restaurantId)
          .collection("RestaurantInfo")
          .doc("MessageToken")
          .get();

      if (value.exists) {
        Map<String, dynamic> data = value.data()!;
          token =  data["Token"];
        if (onSuccess != null) onSuccess();
      }

    } catch (e) {
      if (onError != null) onError(e);
      print('Error fetching token: $e');
    } finally {
      notifyListeners();
    }
  }
}