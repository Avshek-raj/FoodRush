import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class SearchProvider with ChangeNotifier{
  List<ProductModel> foodProductList = [];
  late ProductModel productModel;
  List<ProductModel> newList = [];
  fetchSearchedItem(String searchItem) async{
    QuerySnapshot value = (await FirebaseFirestore.instance
        .collection('FoodProducts')
        .where('productName', isEqualTo: searchItem)
        .snapshots()) as QuerySnapshot<Object?>;
    value.docs.forEach((element) {
      productModel = ProductModel(productId: element.get("productId"),productName: element.get("productName"), productImage: element.get("productImage"), productPrice: element.get("productPrice"), productDesc: element.get("productDescription"));
      newList.add(productModel);
    });
    foodProductList = newList;
    notifyListeners();
  }
}