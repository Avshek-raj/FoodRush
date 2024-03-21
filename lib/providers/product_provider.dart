import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodrush/models/product_model.dart';
import 'package:foodrush/providers/location_provider.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:foodrush/restaurantScreens/restaurantHome.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../Screens/home_screen.dart';
import '../models/user_model.dart';
import '../reusable_widgets/reusable_widget.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> foodProductList = [];
  late ProductModel productModel;
  late LocationProvider locationProvider;
  Location location = Location();

  fetchFoodProductData() async {
    isLoading = true;
    List<ProductModel> newList = [];
    try {
    QuerySnapshot value =
    await FirebaseFirestore.instance.collection("FoodProducts").get();
    value.docs.forEach((element) {
      try{
        String? restaurantLatLng;
        try {
           restaurantLatLng = element.get("RestaurantLatLng");
        } catch (e){
          restaurantLatLng = null;
        }
        // Check if "restaurantLatLng" field exists
        if (restaurantLatLng != null) {
          productModel = ProductModel(
            productId: element.get("productId"),
            productName: element.get("productName"),
            productImage: element.get("productImage"),
            productPrice: element.get("productPrice"),
            productDesc: element.get("productDescription"),
            restaurantId: element.get("restaurantId"),
            restaurantName: element.get("restaurantName"),
            restaurantLatLng: restaurantLatLng, // Assign the value if it exists
          );
          newList.add(productModel);
        } else {
          productModel = ProductModel(
            productId: element.get("productId"),
            productName: element.get("productName"),
            productImage: element.get("productImage"),
            productPrice: element.get("productPrice"),
            productDesc: element.get("productDescription"),
            restaurantId: element.get("restaurantId"),
            restaurantName: element.get("restaurantName"), // Assign the value if it exists
          );
          newList.add(productModel);
        }
      }catch (e) {
        print(e);
      }

    });
    foodProductList = newList;
    fetchNearestFoods(newList);
  }catch (e) {
    print(e);
  }
    notifyListeners();
  }

  Future<void> fetchRestaurantProducts() async {
    try {
      isLoading = true;
      List<ProductModel> newList = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("FoodProducts")
          .where('restaurantId',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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

  get getFoodProductsDataList {
    return foodProductList;
  }

  List<ProductModel> nearestFoods = [];
  fetchNearestFoods(foodList) async {
    isLoading = true;
    List<ProductModel> newList = [];
    try{
    LocationData currentLocation = await location.getLocation();
    if (currentLocation != null) {
      for (int i = 0; i < foodList.length; i++) {
        if (foodList[i].restaurantLatLng!= null){
          LatLng restaurantLocation = getLatLngFromString(foodList[i].restaurantLatLng)!;
          double haversine = calculateDistance(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
            restaurantLocation!.latitude!,
            restaurantLocation!.longitude!,
          );
          if (haversine <=20){
            newList.add(ProductModel(
              productId: foodList[i].productId,
              productName: foodList[i].productName,
              productImage: foodList[i].productImage,
              productPrice: foodList[i].productPrice,
              productDesc: foodList[i].productDesc,
              restaurantId: foodList[i].restaurantId,
              restaurantName: foodList[i].restaurantName,
              restaurantLatLng: foodList[i].restaurantLatLng,
              distance: haversine,
            ));
          }
        }

      }
      if (newList.length >1){
        newList.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
      }
    }
  }catch(e) {
  print(e);
  } finally {

      nearestFoods = newList;
      isLoading = false;
      notifyListeners();
    }

  }
}
