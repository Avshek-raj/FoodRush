import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/models/location_model.dart';

import '../reusable_widgets/reusable_widget.dart';

class DeliveryProvider with ChangeNotifier {
  void addDeliveryData({
    required BuildContext context, // Add required BuildContext parameter
    String? name,
    String? address,
    String? landmark,
    String? phone,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("UserInfo")
          .doc("DeliveryInfo")
          .set({
        "Name": name,
        "Address": address,
        "Landmark": landmark,
        "Phone": phone,
      }).then((_) {
        deliveryIngoModel.name  = name;
        deliveryIngoModel.landmark = landmark;
        deliveryIngoModel.address = address;
        deliveryIngoModel.phone = phone;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Date uploaded successfully'),
        ));
        if (onSuccess != null) onSuccess(); // Call success callback
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
    }
  }
  void fetchDeliveryInfo(Function callback) async {
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
        DeliveryInfoModel deliveryInfoModel = DeliveryInfoModel(
          name: data["Name"] ?? "",
          address: data["Address"] ?? "",
          landmark: data["Landmark"] ?? "",
          phone: data["Phone"] ?? "",
        );
        newList.add(deliveryInfoModel);
      }
      callback(newList);
    } catch (e) {
      print('Error fetching delivery info: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}