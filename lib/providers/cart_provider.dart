import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/home_screen.dart';
import '../models/cart_model.dart';
class CartProvider with ChangeNotifier {
  void addReviewCartDate({
    required BuildContext context, // Add required BuildContext parameter
    String? cartId,
    String? cartImage,
    String? cartPrice,
    String? cartName,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("Cart")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("YourCart")
          .doc(cartId)
          .set({
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "CartPrice": cartPrice,
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add product: $e'),
      ));
    }
  }

  List<CartModel> cartList = [];
  late CartModel cartModel;

  fetchCartData() async{
    isLoading = true;
    List<CartModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance.collection("FoodProducts").get();
    value.docs.forEach((element) {
      cartModel = CartModel(cartId: element.get("productId"),cartName: element.get("productName"), cartImage: element.get("productImage"), cartPrice: element.get("productPrice"));
      newList.add(cartModel);
    });
    cartList = newList;
    isLoading = false;
    notifyListeners();
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in cartList) {
      totalPrice += double.parse(item.cartPrice ?? '0');
    }
    return totalPrice;
  }

  get getFoodProductsDataList{
    return cartList;
  }
}