import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodrush/ui_custom/customElevatedButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';

class EditProfileUser extends StatefulWidget {
  const EditProfileUser({Key? key}) : super(key: key);

  @override
  State<EditProfileUser> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileUser> {
  final _formKey = GlobalKey<FormState>();
  File? _image;

  // Function to pick image from gallery
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          // Navigate back to the previous page
                          Navigator.pop(context);
                        },
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
                // GestureDetector to handle avatar image change
                GestureDetector(
                  onTap: getImage,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: _image != null ? FileImage(_image!) : AssetImage("assets/images/p22.png") as ImageProvider,
                  ),
                ),
                                Text("Tap on the Circle Avatar to change your profile image",style: TextStyle(fontWeight: FontWeight.w500),),

                // Fields to edit
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    labelText: "User Name",
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.red,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 10),
                // Other form fields...
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
      Icons.phone,
      color: Colors.red,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter your phone number";
      } else if (value.length != 10) {
        return "The phone number should be exactly 10 characters";
      }
      return null;
    },
    onChanged: (value) {},
    keyboardType: TextInputType.phone, // Set keyboard type to phone
  ),
),
SizedBox(height: 10),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Ctextform(
    labelText: "Address",
    prefixIcon: Icon(
      Icons.location_on_outlined,
      color: Colors.red,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter your address";
      }
      return null;
    },
    onChanged: (value) {},
  ),
),
SizedBox(
  height: 30,
),
CustomElevatedButton(onPressed: (){

}
, child: Text("Save")),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
