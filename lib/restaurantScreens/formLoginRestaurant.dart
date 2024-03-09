import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';
import 'package:image_picker/image_picker.dart';

class FormLoginRestaurant extends StatefulWidget {
  const FormLoginRestaurant({super.key});

  @override
  State<FormLoginRestaurant> createState() => _FormLoginRestaurantState();
}

class _FormLoginRestaurantState extends State<FormLoginRestaurant> {
  File? file;
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset("assets/images/logo_pureRed.png",
                      // height: 150,
                      // width: 150,
                      // ),
                      Text(
                        "Add Your Restaurant",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),

                    ],
                  ),
                ),

                //yo edit garne field haru
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    labelText: "Restaurant Name",
                    prefixIcon: Icon(
                      Icons.dinner_dining_outlined,
                      color: Colors.red,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please add Your Restaurant Name";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                        return emailValidatorStr;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                        return addressValidatorStr;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {},
                  ),
                ),
                  SizedBox(
                  height: 20,
                ),
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
                        return phoneValidatorStr;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {},
                  ),
                ),
                  SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    labelText: "About Restaurant",
                    prefixIcon: Icon(
                      Icons.description_outlined,
                      color: Colors.red,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please write something about your restaurant";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //upload image of food
                //FOR DOTTED BORDER
                GestureDetector(
                  //yo chai thichda gallery ma jana ko lagi or inkwell use garda pani hunxa (inkwell for text)
                  onTap: () {
                    pickImageFromGallery();
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    padding: EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        child: file == null
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                  ),
                                  Icon(
                                    Icons.file_upload_outlined,
                                    color: Colors.red,
                                    size: 45,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Upload your restaurant image here",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
            //yedi file null xaina vane image.file means device ko file bata image liyera dekhaune ano dotted border vitra fill hune gare select gareko photo dekhaune
                              )
                            : Image.file(
                                file!,
                                fit: BoxFit.cover,
                              ),
                        height: 250,
                        width: 320,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: Colors.red,
                      ),
                      onPressed: () {},
                      child: Text("Submit")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImageFromGallery() async {
    //gallery bata image pick garna ko lagi banako function
    final ImagePicker picker = ImagePicker();
// Pick an image.
    image = await picker.pickImage(source: ImageSource.gallery);
    print(image);
    if (image == null)
      return; //yedi image null xa vane or user le image select gareko xaina vane tye bata rokera bahira jane
    file = File(image!.path); //image ko path liyeko
    setState(() {
      file;
      image; //file and image dubai aaye paxi dubai lai aru thau ma notify garnu xa tyesaile
    });
  }
}
