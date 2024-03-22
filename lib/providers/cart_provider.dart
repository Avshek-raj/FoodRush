import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/reusable_widgets/reusable_widget.dart';

import '../Screens/home_screen.dart';
import '../models/cart_model.dart';
class CartProvider with ChangeNotifier {
  void addReviewCartData({
    required BuildContext context, // Add required BuildContext parameter
    String? cartId,
    String? cartImage,
    String? cartPrice,
    String? cartName,
    int? cartQuantity,
    String? restaurantName,
    String? restaurantId,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("Cart")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("CartItems")
          .doc(cartId)
          .set({
        "CartId": cartId,
        "CartName": cartName,
        "CartImage": cartImage,
        "CartPrice": cartPrice,
        "CartQuantity": cartQuantity,
        "RestaurantName": restaurantName,
        "RestaurantId": restaurantId
      }).then((_) {
        print('Product added in cart successfully');
        if (onSuccess != null) onSuccess(); // Call success callback
      }).catchError((error) {
        print('Product add in cart failed:$error');
        if (onError != null) onError(error); // Call error callback
      });
    } catch (e) {
      print('Product add in cart failed:$e');
    }
  }

  List<CartModel> cartList = [];
  late CartModel cartModel;
  fetchCartData(callback) async{
    isLoading = true;
    List<CartModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance.collection("Cart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("CartItems").get();
    value.docs.forEach((element) {
      cartModel = CartModel(cartId: element.get("CartId"),cartName: element.get("CartName"), cartImage: element.get("CartImage"), cartPrice: element.get("CartPrice"), cartQuantity: element.get("CartQuantity"), restaurantId: element.get("RestaurantId"), restaurantName: element.get("RestaurantName"));
      newList.add(cartModel);
    });
    cartList = newList;
    cartItemNumber = cartList.length;
    isLoading = false;
    callback();
    notifyListeners();
  }

  deleteCartItem(cartId) async{
    isLoading = true;
    List<CartModel> newList = [];
    await  FirebaseFirestore.instance.collection("Cart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("CartItems").doc(cartId).delete();
    cartItemNumber = cartItemNumber! - 1;
    notifyListeners();
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (var item in cartList) {
      int price = int.parse(item.cartPrice ?? '0');
      int quantity = int.parse(item.cartQuantity?.toString() ?? '0');
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
  List<CartModel> historyList = [];
  late CartModel historyModel;
  fetchHistoryData(callback) async {
    try {
      isLoading = true;
      List<CartModel> newList = [];

      QuerySnapshot value = await FirebaseFirestore.instance
          .collection("OrderHistory")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("OrderList")
          .get();

      value.docs.forEach((element) {
         historyModel = CartModel(
          cartId: element.get("OrderId"),
          cartName: element.get("OrderName"),
          cartImage: element.get("OrderImage"),
          cartPrice: element.get("OrderPrice"),
          cartQuantity: element.get("OrderQuantity"),
          restaurantName: element.get("RestaurantName"),
        );

        newList.add(historyModel);
      });

      historyList = newList;
      cartItemNumber = historyList.length;
    } catch (e) {
      print("Error fetching history data: $e");
    } finally {
      isLoading = false;
      callback();
      notifyListeners();
    }
  }


}