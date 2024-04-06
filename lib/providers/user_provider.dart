import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/models/location_model.dart';
import 'dart:io';
import '../Screens/home_screen.dart';
import '../models/user_model.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:provider/provider.dart';
class UserProvider with ChangeNotifier {
  void addUserDetails({
    required BuildContext context,
    String? username,
    String? email,
    String? phone,
    String? address,
    String? password,
    String? role,
    String? userImage,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("UserInfo")
          .doc("Details")
          .set({
        "Username": username,
        "Email": email,
        "Phone": phone,
        "Address": address,
        "Password": password,
        "Role": role,
        "PhotoUrl": userImage??"",
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

  List<UserModel> userInfoList = [];
  UserModel userModel = UserModel();
  DeliveryInfoModel deliveryInfoModel = DeliveryInfoModel();
  String token = "";

  fetchUserData(String? userId, callback) async {
    try {
      isLoading = true;
      List<UserModel> newList = [];
      if (userId == null || userId ==""){
        userId = FirebaseAuth.instance.currentUser?.uid;
      }
      QuerySnapshot value = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("UserInfo")
          .get();
      value.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        bool deliveryInfo = data.containsKey("Name");
        if (deliveryInfo) {
          deliveryInfoModel = DeliveryInfoModel(
              name: data["Name"],
              address: data["Address"],
              landmark: data["Landmark"],
              phone: data["Phone"]);
              latLng: data["LatLng"];
        } else if (data.containsKey("Token")){
          token = data["Token"];
        } else {
          userModel = UserModel(
              username: data["Username"],
              email: data["Email"],
              address: data["Address"],
              phone: data['Phone'],
              password: data["Password"],
              deliveryInfo: data["DeliveryInfo"],
              token:data["Token"],
              userImage: data["PhotoUrl"],
              role: data["Role"]
          );
        }
      });
      userInfoList = newList;
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      callback();;
      notifyListeners();
    }
  }

  void fetchDeliveryInfo({
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      isLoading = true;
      List<DeliveryInfoModel> newList = [];
      DocumentSnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("UserInfo")
          .doc("DeliveryInfo")
          .get();

      if (value.exists) {
        Map<String, dynamic> data = value.data()!;
        deliveryInfoModel = DeliveryInfoModel(
          name: data["Name"] ?? "",
          address: data["Address"] ?? "",
          landmark: data["Landmark"] ?? "",
          phone: data["Phone"] ?? "",
          latLng: data["DeliveryLatLng"]?? ""
        );
        newList.add(deliveryInfoModel);
        if (onSuccess != null) onSuccess();
      }

    } catch (e) {
      if (onError != null) onError(e);
      print('Error fetching delivery info: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void editUserDetails({
    required BuildContext context,
    String? username,
    String? email,
    String? phone,
    String? address,
    String? password,
    File? newUserImage,
    String? userImage,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      String imageUrl = "";
      if (newUserImage != null) {
        imageUrl = await uploadImageToFirebase(newUserImage!) as String;
      }

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("UserInfo")
          .doc("Details")
          .update({
        "Username": username,
        "Email": email,
        "Phone": phone,
        "Address": address,
        "Password": password,
        "PhotoUrl": imageUrl != ""? imageUrl :userImage??"",
      }).then((_) {
          print('Data uploaded Successfully');
        if (onSuccess != null) onSuccess();
      }).catchError((error) {
          print('Failed to upload data: $error');
        if (onError != null) onError(error); // Call error callback
      });
    } catch (e) {
        print('Failed to upload data: $e');
      if (onError != null) onError(e);
    }
  }
}

Future<String?> uploadImageToFirebase(File imageFile) async {
  try {
    // Convert XFile to File
    File file = File(imageFile.path);

    // Create a reference to the location you want to upload to in Firebase Storage
    Reference storageReference = FirebaseStorage.instance.ref().child('UserImages').child(DateTime.now().millisecondsSinceEpoch.toString());

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
