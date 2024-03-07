import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

Color myColor = Colors.red;

String nameStr="Name";
String nameValidationStr="Please enter your name";

String emailStr="Email";
String emailValidatorStr= "Please enter your email address";

String phoneStr="Phone";
String phoneValidatorStr="Please enter your phone number";

String addressStr="Address";
String addressValidatorStr="Please enter your address";

String genderStr="Gender";
String genderValidatorStr="Please enter your gender";

String passwordStr="Password";
String passwordValidatorStr="Please enter your password";


String foodNameStr="Food Name";
String foodNameValidatorStr="Please enter the name of food";

String foodPricetr="Food Price";
String foodpriceValidatorStr="Please enter the price of food";

String foodDescriptionStr="Food Name";
String foodDescriptionValidatorStr="Please write something about your food";
