import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart'; // Import Services

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  Future getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
//
  @override
  Widget build(BuildContext context) {
        UserProvider userProvider = Provider.of<UserProvider>(context);
        RestaurantProvider restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edit Profile",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ],
                ),
              ),
              // Container for circle avatar
              GestureDetector(
                onTap: getImage,
                child: _image != null
                    ? CircleAvatar(
                  radius: 45,
                  backgroundImage: FileImage(_image!),
                )
                    : userProvider.userModel.userImage != null
                    ? CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(userProvider.userModel.userImage!),
                )
                    : CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.person_outline),
                ),
              ),
              // Container(
              //   height: 90,
              //   width: 90,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: Colors.grey.shade300,
              //       width: 1,
              //     ),
              //   ),
              //   child: CircleAvatar(
              //     radius: 25,
              //     child: Icon(Icons.person_outlined, color: Colors.red, size: 30),
              //     backgroundColor: Colors.transparent,
              //   ),
              // ),
              // Fields to edit
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: "Restaurant Name",
                  prefixIcon: Icon(
                    Icons.restaurant_outlined,
                    color: Colors.red,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the restaurant name";
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: "Owner Name",
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.red,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the owner name";
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: "Address",
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the address";
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: "Email",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.red,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: "Phone",
                  prefixIcon: Icon(
                    Icons.phone_iphone_rounded,
                    color: Colors.red,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    } else if (value.length != 10) {
                      return "The phone number should be exactly 10 digits";
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  keyboardType: TextInputType.phone, // Set keyboardType to phone
                ),
              ),
              SizedBox(height: 110),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // Add your save logic here
                  },
                  child: Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
