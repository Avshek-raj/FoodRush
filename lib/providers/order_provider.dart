import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/reusable_widgets/reusable_widget.dart';

import '../Screens/home_screen.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
class OrderProvider with ChangeNotifier {
  void addOrderData({// Add required BuildContext parameter
    String? orderId,
    String? userImage,
    String? orderPrice,
    String? orderName,
    int? orderQuantity,
    String? userName,
    String? userId,
    String? restaurantId,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("Order")
          .doc(restaurantId)
          .collection("OrderItems")
          .doc(orderId)
          .set({
        "OrderId": orderId,
        "OrderName": orderName,
        "UserImage": userImage,
        "OrderPrice": orderPrice,
        "OrderQuantity": orderQuantity,
        "UserName": userName,
        "UserId": userId
      }).then((_) {
        print("Orders pulled successfully");
        if (onSuccess != null) onSuccess(); // Call success callback
      }).catchError((error) {
        print("Order pull failed");
        if (onError != null) onError(error); // Call error callback
      });
    } catch (e) {
      print('Order pull failed: $e');
    }
  }

  List<OrderModel> cartList = [];
  late OrderModel orderModel;
  fetchOrderData(callback) async{
    isLoading = true;
    List<OrderModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance.collection("Order")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("OrderItems").get();
    value.docs.forEach((element) {
      orderModel = OrderModel(orderId: element.get("OrderId"),orderName: element.get("OrderName"), userImage: element.get("UserImage"), orderPrice: element.get("OrderPrice"), orderQuantity: element.get("OrderQuantity"), userName: element.get("UserName"), userId: element.get("UserId"));
      newList.add(orderModel);
    });
    cartList = newList;
    cartItemNumber = cartList.length;
    isLoading = false;
    callback();
    notifyListeners();
  }

  deleteOrder(orderId) async{
    isLoading = true;
    List<OrderModel> newList = [];
    await  FirebaseFirestore.instance.collection("Cart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("CartItems").doc(orderId).delete();
    cartItemNumber = cartItemNumber! - 1;
    notifyListeners();
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (var item in cartList) {
      int price = int.parse(item.orderPrice ?? '0');
      int quantity = int.parse(item.orderQuantity?.toString() ?? '0');
      totalPrice += price * quantity;
    }
    return totalPrice;
  }

  get getFoodProductsDataList{
    return cartList;
  }

  getNumOfCartItem(){
    return cartList.length;
  }
}