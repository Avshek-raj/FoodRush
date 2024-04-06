import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodrush/Screens/Navigation.dart';
import 'package:foodrush/Screens/profile_screen.dart';
import 'package:foodrush/login/forgotPw1.dart';
import 'package:foodrush/ui_custom/customElevatedButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class EditProfileUser extends StatefulWidget {
  const EditProfileUser({Key? key}) : super(key: key);

  @override
  State<EditProfileUser> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileUser> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  late UserProvider userProvider;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

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
    userProvider = Provider.of(context);
    username.text =  userProvider.userModel.username?? "";
    email.text = userProvider.userModel.email?? "";
    phone.text = userProvider.userModel.phone?? "";
    address.text = userProvider.userModel.address?? "";

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

                SizedBox(height: 5,),
                Text("Change profile image",style: TextStyle(fontWeight: FontWeight.w500),),

                // Fields to edit
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    controller: username,
                    labelText: "Username",
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
    controller: email,
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
    controller: phone,
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
    controller: address,
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
  userProvider.editUserDetails(context: context, username: username.text, email: email.text, phone: phone.text, address: address.text, userImage: userProvider.userModel.userImage, newUserImage: _image,
  onSuccess: (){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Success"),
        content: Text("User profile updated successfully"),
        actions: [
          TextButton(onPressed: ()async{
            await userProvider.fetchUserData("", (){});
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainScreen(page: 4,)));
          }, child: Text('OK'))
        ],
      );
    });
  },
  onError: (e){
    AlertDialog(
      title: Text("Error"),
      content: Text("An error occured. Please ty again"),
      actions: [
        TextButton(onPressed: ()async{
          Navigator.pop(context);
        }, child: Text('OK'))
      ],
    );
  });
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
