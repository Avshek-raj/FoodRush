import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantModel {
  String? restaurantName;
  String? email;
  String? address;
  String? phone;
  String? password;
  String? about;
  XFile? restaurantImage;
  String? token;
  RestaurantModel({this.restaurantName,this.email,this.address,this.phone,this.password, this.about, this.restaurantImage, this.token});
}

class RestaurantProvider with ChangeNotifier {
  void addRestaurantDetails({
    required BuildContext context,
    String? restaurantName,
    String? email,
    String? phone,
    String? address,
    String? password,
    String? about,
    XFile? restaurantImage,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("RestaurantUsers")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("RestaurantInfo")
          .add({
        "RestaurantName": restaurantName,
        "Email": email,
        "Phone": phone,
        "Address": address,
        "Password": password,
        "About": about,
        "Role": "Restaurant"
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data uploaded Successfully'),
        ));
        if (onSuccess != null) onSuccess();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload data: $error'),
        ));
        if (onError != null) onError(error); // Call error callback
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload data: $e'),
      ));
      if (onError != null) onError(e);
    }
  }

  List<RestaurantModel> restaurantInfoList = [];
  RestaurantModel restaurantModel = RestaurantModel();
  fetchRestaurantDetails(userId,callback) async {
    String uid = userId ?? FirebaseAuth.instance.currentUser?.uid;
    List<RestaurantModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("RestaurantUsers")
        .doc(uid)
        .collection("RestaurantInfo")
        .get();
    value.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      restaurantModel = RestaurantModel(
          restaurantName: data["Username"],
          email: data["Email"],
          address: data["Address"],
          phone: data['phone'],
          password: data["Password"],
          about: data["About"],
          token: data["Token"],
      );
    });
    restaurantInfoList = newList;
    callback(restaurantModel);
    notifyListeners();
  }
}