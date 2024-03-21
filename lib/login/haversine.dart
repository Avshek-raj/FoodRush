import 'dart:html';

import 'package:foodrush/models/product_model.dart';
import 'package:geocoding/geocoding.dart';

import '../reusable_widgets/reusable_widget.dart';

Future<void> fetchNearestFoods(currentLocation, restaurantLocation, foodList) async {
  if (currentLocation != null) {
    List<ProductModel> nearestFoods = [];

    double lat = restaurantLocation.latitude;
    double long = restaurantLocation.longitude;


    // Calculate distances and get nearest foods
    for (int i = 0; i < foodList.length; i++) {
      double haversine = calculateDistance(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        lat,
        long,
      );


      nearestFoods.add(foodList(
        productId: foodList[i].productId,
        productName: foodList[i].productName,
        productImage: foodList[i].productImage,
        productPrice: foodList[i].productPrice,
        productDesc: foodList[i].productDescription,
        restaurantId: foodList[i].restaurantId,
        restaurantName: foodList[i].restaurantName,
        distance: haversine,
      ));
    }

    nearestFoods.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));


  }
}
