import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodrush/models/product_model.dart';

import '../Screens/home_screen.dart';

class ProductProvider with ChangeNotifier{

  List<ProductModel> foodProductList = [];
  late ProductModel productModel;

  fetchFoodProductData() async{
    isLoading = true;
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance.collection("FoodProducts").get();
    value.docs.forEach((element) {
      productModel = ProductModel(productName: element.get("productName"), productImage: element.get("productImage"), productPrice: element.get("productPrice"), productDesc: element.get("productDescription"));
      newList.add(productModel);
    });
    foodProductList = newList;
    isLoading = false;
    notifyListeners();
  }

  get getFoodProductsDataList{
    return foodProductList;
  }

}