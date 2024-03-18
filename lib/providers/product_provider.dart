
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodrush/models/product_model.dart';
import 'package:foodrush/restaurantScreens/restaurantHome.dart';

import '../Screens/home_screen.dart';
import '../reusable_widgets/reusable_widget.dart';

class ProductProvider with ChangeNotifier{

  List<ProductModel> foodProductList = [];
  late ProductModel productModel;

  fetchFoodProductData() async{
    isLoading = true;
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance.collection("FoodProducts").get();
    value.docs.forEach((element) {
      productModel = ProductModel(productId: element.get("productId"),productName: element.get("productName"), productImage: element.get("productImage"), productPrice: element.get("productPrice"), productDesc: element.get("productDescription"), restaurantId: element.get("restaurantId"), restaurantName: element.get("restaurantName"));
      newList.add(productModel);
    });
    foodProductList = newList;
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRestaurantProducts() async {
    try {
      isLoading = true;
      List<ProductModel> newList = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("FoodProducts")
          .where('restaurantId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

      querySnapshot.docs.forEach((document) {
        ProductModel productModel = ProductModel(
          productId: document.get("productId"),
          productName: document.get("productName"),
          productImage: document.get("productImage"),
          productPrice: document.get("productPrice"),
          productDesc: document.get("productDescription"),
          restaurantId: document.get("restaurantId"),
          restaurantName: document.get("restaurantName"),
        );
        newList.add(productModel);
      });

      foodProductList = newList;
      isLoading = false;
      notifyListeners(); // Notify listeners after data is fetched
    } catch (e) {
      isLoading = false;
      print("Error fetching restaurant products: $e");
      // Handle error, show error message, etc.
    }
  }


  get getFoodProductsDataList{
    return foodProductList;
  }

}