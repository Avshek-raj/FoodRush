import 'package:flutter/material.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({super.key});

  @override
  State<SettingsProfile> createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SingleChildScrollView(
  child: SafeArea(
    child: Column(
      children: [
         Padding(
               padding: const EdgeInsets.all(10),
               child: Row(
                children: [
                  BackButton(
                    color: Colors.black,
                  ),
                  SizedBox(width: 10,),
                  // Spacer(),
                  Text("Settings",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                ],
                       ),
             ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    height: 58, // Adjust height as needed
    padding: EdgeInsets.symmetric(horizontal: 12), // Padding for icons and content
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.privacy_tip_sharp,color: Colors.red,), // Replace 'prefix_icon' with your desired prefix icon
        SizedBox(width: 15,),
        Text("Privacy policy",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
Spacer(),
        Icon(Icons.arrow_forward_ios_rounded,color: Colors.red,), // Replace 'suffix_icon' with your desired suffix icon
      ],
    ),
  ),
),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    height: 58, // Adjust height as needed
    padding: EdgeInsets.symmetric(horizontal: 12), // Padding for icons and content
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.lock_outline,color: Colors.red,), // Replace 'prefix_icon' with your desired prefix icon
        SizedBox(width: 15,),
        Text("Change Password",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
Spacer(),
        Icon(Icons.arrow_forward_ios_rounded,color: Colors.red,), // Replace 'suffix_icon' with your desired suffix icon
      ],
    ),
  ),
),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    height: 58, // Adjust height as needed
    padding: EdgeInsets.symmetric(horizontal: 12), // Padding for icons and content
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.fastfood_outlined,color: Colors.red,), // Replace 'prefix_icon' with your desired prefix icon
        SizedBox(width: 15,),
        Text("Add Food",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
Spacer(),
        Icon(Icons.arrow_forward_ios_rounded,color: Colors.red,), // Replace 'suffix_icon' with your desired suffix icon
      ],
    ),
  ),
),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    height: 58, // Adjust height as needed
    padding: EdgeInsets.symmetric(horizontal: 12), // Padding for icons and content
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.logout_outlined,color: Colors.red,), // Replace 'prefix_icon' with your desired prefix icon
        SizedBox(width: 15,),
        Text("LogOut",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
Spacer(),
       // Replace 'suffix_icon' with your desired suffix icon
      ],
    ),
  ),
),
Padding(
  padding: const EdgeInsets.only(right:19,top: 10),
  child: Row(
    children: [
      Spacer(),
      Icon(Icons.arrow_forward_ios_rounded,color: Colors.red,)
    ],
  ),
)
      ],
    ),
  ),
),
    );
  }
}