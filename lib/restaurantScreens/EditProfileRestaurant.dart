import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'navbarRestaurant.dart'; // Import Services

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController restaurantName = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
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
        restaurantName.text = restaurantProvider.restaurantModel.restaurantName?? "";
        email.text = restaurantProvider.restaurantModel.email?? "";
        phone.text = restaurantProvider.restaurantModel.phone?? "";
        address.text = restaurantProvider.restaurantModel.address?? "";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                SizedBox(height: 20,),
                // Container for circle avatar
                GestureDetector(
                  onTap: getImage,
                  child: _image != null
                      ? CircleAvatar(
                    radius: 45,
                    backgroundImage: FileImage(_image!),
                  )
                      : restaurantProvider.restaurantModel.restaurantImageLink != null
                      ? CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(restaurantProvider.restaurantModel.restaurantImageLink!),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    controller: restaurantName,
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
                // SizedBox(height: 10),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Ctextform(
                //     controller: ownerName,
                //     labelText: "Owner Name",
                //     prefixIcon: Icon(
                //       Icons.person_outline,
                //       color: Colors.red,
                //     ),
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please enter the owner name";
                //       }
                //       return null;
                //     },
                //     onChanged: (value) {},
                //   ),
                // ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    controller: address,
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
                SizedBox(height: 15),
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
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    controller: phone,
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
                      restaurantProvider.editRestaurantDetails(context: context, restaurantName: restaurantName.text, email: email.text, phone: phone.text, address: address.text, restaurantImageUrl: restaurantProvider.restaurantModel.restaurantImageLink, newRestaurantImage: _image,
                          onSuccess: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Success"),
                                    content: Text("Restaurant profile updated successfully"),
                                    actions: [
                                      TextButton(onPressed: ()async{
                                        await restaurantProvider.fetchRestaurantDetails("", (){});
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => NavbarRestaurant(page: 3,)));
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
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
