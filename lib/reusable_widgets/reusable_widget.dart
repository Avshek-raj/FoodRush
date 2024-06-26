

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodrush/Screens/Navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../Screens/MenuPage.dart';
import '../Screens/cart_screen.dart';
import '../restaurantScreens/navbarRestaurant.dart';
import '../utils/color_utils.dart';

import '../models/location_model.dart';
int? cartItemNumber;

String? deliveryAddress;
String? deliveryLandmark;

String? role;


bool isLoading = false;

DeliveryInfoModel deliveryIngoModel = DeliveryInfoModel();

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width:320,
    height: 320,
  );
}
//for textformfiled
// TextFormField reusableTextFormField(String text, IconData icon, String fieldInputType,
//     TextEditingController controller) {
//   bool isPasswordType = fieldInputType == 'password'? true : false;
//   return TextFormField(
//     controller: controller,
//     obscureText: isPasswordType,
//     enableSuggestions: !isPasswordType,
//     autocorrect: !isPasswordType,
//     cursorColor: Colors.black,
//     style: TextStyle(color: Colors.black.withOpacity(0.9)),
//       validator: (value){
//         if (isPasswordType){
//           if (value!.isEmpty){
//             return "Please enter your password";
//           } else if(value.length <=7) {
//             return "The password should be at least 8 characters";
//           }
//         }else {
//           if (value!.isEmpty) {
//             return 'Please enter your ' + text.toLowerCase();
//           }
//         }
//         if (isPasswordType){
//           if (value!.isEmpty){
//             return "Please enter your password";
//           } else if(value.length <=7) {
//             return "The password should be at least 8 characters";
//           }
//         }
//         return null;
//       },
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.symmetric(vertical: 16.0),
//       prefixIcon: Icon(
//         icon,
//         color: Colors.red,
//       ),
//       labelText: text,
//       labelStyle: TextStyle(color: Colors.black54),
//       fillColor: Colors.white.withOpacity(0.3),
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: BorderSide(color: Colors.red,)),
//     ),
//     keyboardType: fieldInputType == 'password'
//         ? TextInputType.visiblePassword
//         : fieldInputType == 'email' ? TextInputType.emailAddress
//         : fieldInputType == 'phone' ? TextInputType.phone
//         : TextInputType.text
//   );
// }

TextFormField reusableTextFormField(String text, IconData icon, String fieldInputType,
    TextEditingController controller) {
  bool isPasswordType = fieldInputType == 'password';
  bool isEmailType = fieldInputType == 'email';
  bool isPhoneType = fieldInputType == 'phone';

  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    validator: (value){
      if (isPasswordType){
        if (value!.isEmpty){
          return "Please enter your password";
        } else if(value.length <=7) {
          return "The password should be at least 8 characters";
        }
      } else if (isEmailType) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      } else if (isPhoneType) {
        if (value!.isEmpty) {
          return 'Please enter your phone number';
        } else if (value.length < 10) {
          return 'The phone number should be of 10 characters';
        }
      } else {
        if (value!.isEmpty) {
          return 'Please enter your ' + text.toLowerCase();
        }
      }
      return null;
    },
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
      prefixIcon: Icon(
        icon,
        color: Colors.red,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black54),
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.red,)),
           focusedBorder: OutlineInputBorder(
            // Set focused border color to red
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.red),
          ),
    ),
    keyboardType: fieldInputType == 'password'
        ? TextInputType.visiblePassword
        : fieldInputType == 'email' ? TextInputType.emailAddress
        : fieldInputType == 'phone' ? TextInputType.phone
        : TextInputType.text,
  );
}



Container loginButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: 250,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white12;
            }
            return Colors.red;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Container customLoginButton(BuildContext context, String title, String logo, Color borderColor, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      border: Border.all(
        color: Colors.grey,
        width: 1.0,
      )
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            logo, // Replace with your Google logo asset
            height: 30.0,
          ),
          SizedBox(width: 20,),
          //Icon(Icons.supervised_user_circle),
          Text(
            title,
            style: TextStyle(
                color: Colors.black54,  fontSize: 16),
          ),
        ],
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.red;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Row dividerOrLine() {
  return Row(
    children: [
      Expanded(
        child: Divider(
          color:Colors.black,
          height: 20
        )
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('OR'),
      ),
      Expanded(
          child: Divider(
              color:Colors.black,
              height: 20
          )
      ),
    ],
  );
}
//for textfiled
TextField reusableTextField(String text, IconData icon, String fieldInputType,
    TextEditingController controller, Function(String)? onSubmittedCallback) {
  bool isPasswordType = fieldInputType == 'password'? true : false;
  return TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
      decoration: InputDecoration(
        
          focusedBorder: OutlineInputBorder(
            // Set focused border color to red
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.red),
          ),
        contentPadding: EdgeInsets.symmetric(vertical: 14.0),
        prefixIcon: Icon(
          icon,
          color: Colors.red,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black54),
        filled: false,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        //fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.red,)),
      ),
      keyboardType: fieldInputType == 'password'
          ? TextInputType.visiblePassword
          : fieldInputType == 'email' ? TextInputType.emailAddress
          : fieldInputType == 'phone' ? TextInputType.phone
          : TextInputType.text,
      onSubmitted: (value) {
        if (onSubmittedCallback != null) {
          onSubmittedCallback(value);
        }
      },
  );
}
GestureDetector menuItem(BuildContext context, String itemName, String icon, int page) {
  return GestureDetector(
    onTap: () {
      // Navigate to the menu screen when the menu item is tapped
      Navigator.push(context, MaterialPageRoute(builder: (context) => Menu(initialTabIndex: page,)));
    },
    child: Container(
      height: 76,
      width: 76,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              child: Image.asset(
                icon,
                height: 45,
                width: 45,
              ),
            ),
          ),
          SizedBox(height: 4), // Adding some space between icon and text
          // Wrap the Text widget with Flexible to prevent overflow
          Flexible(
            child: Text(
              style: TextStyle(fontWeight: FontWeight.w400),
              itemName,
              textAlign: TextAlign.center, // Adjust text alignment if needed
              overflow: TextOverflow.clip, // Handle overflow by ellipsis
              maxLines: 2, // Limit maximum lines to prevent excessive overflow
            ),
          ),
        ],
      ),
    ),
  );
}


Container setItemCount(int count) {
  return Container(
    height: 30,
    width: 107,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(40),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () {

              if (count > 0) {
                count--;
              }
          },
          icon: Icon(Icons.remove), iconSize: 15,
        ),
        Text(
          count.toString(), // Counter value
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
              count++;
          },
          icon: Icon(Icons.add), iconSize: 15,
        ),
      ],
    ),
  );
}

class CartBadge extends StatelessWidget {
  final int itemCount;

  const CartBadge({
    Key? key,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(page:3 ,)),
        );
      },
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      icon: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          Icon(Icons.shopping_cart),
          if (itemCount > 0)
            Positioned(
              top: -5,
              right: -5,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Text(
                  itemCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


LatLng? getLatLngFromString( coordinatesString) {
  if (coordinatesString == null) {
    return null;
  }
  String cleanedString = coordinatesString.replaceAll("LatLng(", "").replaceAll(")", "");

  List<String> parts = cleanedString.split(", ");
  if (parts.length == 2) {
    double? latitude = double.tryParse(parts[0]);
    double? longitude = double.tryParse(parts[1]);

    if (latitude != null && longitude != null) {
      return LatLng(latitude, longitude);
    } else {
      print('Invalid coordinates format.');
      return null;
    }
  } else {
    print('Invalid coordinates format.');
    return null;
  }
}

////Haversine algo.
double calculateDistance(
    double startLat,
    double startLong,
    double endLat,
    double endLong,
    ) {
  const int earthRadius = 6371; // Earth's radius in kilometers

  // Convert degrees to radians
  double startLatRad = _degreesToRadians(startLat);
  double startLongRad = _degreesToRadians(startLong);
  double endLatRad = _degreesToRadians(endLat);
  double endLongRad = _degreesToRadians(endLong);

  // Calculate the difference between coordinates
  double latDiff = endLatRad - startLatRad;
  double longDiff = endLongRad - startLongRad;

  // Calculate distance using Haversine formula
  double a = pow(sin(latDiff / 2), 2) +
      cos(startLatRad) * cos(endLatRad) * pow(sin(longDiff / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}


Future<bool> checkDocumentExists(String collectionName, String documentId) async {
  bool exist = false;
  try {
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentId)
        .collection("UserInfo")
        .get();
    value.docs.forEach((element) {
      exist = true;
    });
    return exist;
  } catch (e) {
    print(e);
    return false;
  }
}


Color getStatusColor(status){
  if (status == "pending"){
    return Colors.red;
  }else if (status == "preparing"){
    return Colors.orange;
  }else if (status == "delivering"){
    return Colors.yellow;
  }else{
    return Colors.green;
  }
}


LatLng? userLatLng;
 _getLocation() async {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  LocationData currentLocation = await location.getLocation();
    isLoading = false;
    userLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
}


class OrderBadge extends StatelessWidget {
  final int itemCount;

  const OrderBadge({
    Key? key,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavbarRestaurant(page:2 ,)),
        );
      },
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      icon: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          itemCount >0 ?Icon(Icons.notifications_on_outlined, size: 27,) :Icon(Icons.notifications_outlined, size: 27,),
          if (itemCount > 0)
            Positioned(
              top: -5,
              right: -5,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Text(
                  itemCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
