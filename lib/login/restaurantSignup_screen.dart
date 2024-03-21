import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Screens/home_screen.dart';
import '../providers/restaurant_provider.dart';
import '../restaurantScreens/navbarRestaurant.dart';
import '../reusable_widgets/reusable_widget.dart';

class RegisterRestaurantScreen extends StatefulWidget {
  const RegisterRestaurantScreen({super.key});

  @override
  State<RegisterRestaurantScreen> createState() => _RegisterRestaurantScreenState();
}

class _RegisterRestaurantScreenState extends State<RegisterRestaurantScreen> {
  late RestaurantProvider restaurantProvider;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController restaurantName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  File? file;
  XFile? restaurantImage;
  @override
  Widget build(BuildContext context) {
    restaurantProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                        "Register your restaurant",
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
                Form(
                    key: _formKey,
                    child: Column(

                      children:[
                        const SizedBox(
                          height: 30,
                        ),
                        reusableTextFormField("Restaurant name", Icons.restaurant_outlined, "text", restaurantName),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Email", Icons.mail_outline, "email", email),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Contact number", Icons.phone_outlined, "phone", phone),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Address", Icons.home, "address", address),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("About Restaurant", Icons.description_outlined, "address", about),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Password", Icons.lock_outline, "password", password),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Confirm Password", Icons.lock_outline, "password", confirmPassword),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          //yo chai thichda gallery ma jana ko lagi or inkwell use garda pani hunxa (inkwell for text)
                          onTap: () {
                            pickImageFromGallery();
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
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
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                loginButton(context, "Sign Up", () {

                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text).then ((value) {
                      value.user?.sendEmailVerification();
                        restaurantProvider.addRestaurantDetails(
                          context: context,
                          restaurantName: restaurantName.text,
                          email: email.text,
                          phone: phone.text,
                          address: address.text,
                          password: password.text,
                          about: about.text,
                          restaurantImage: file,
                          onSuccess: (){
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Message"),
                                    content: Text("Verification link is sent to your email. Please verify before login"),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => SignInScreen()));
                                      }, child: Text('OK'))
                                    ],
                                  );
                                });
                          },
                          onError: (e){
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child: Text('OK'))
                                    ],
                                  );
                                });
                          });
                    }).onError((error, stackTrace) {
                      setState(() {
                        isLoading = false;
                      });showDialog(context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(error.toString()),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text('OK'))
                              ],
                            );
                          });
                      print("Error ${error.toString()}");
                    });
                  }
                  //)
                  // })
                  // FirebaseAuth.instance
                  //     .signInWithEmailAndPassword(
                  //     email: _emailTextController.text,
                  //     password: _passwordTextController.text)
                  //     .then((value) {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => HomeScreen()));
                  // }).onError((error, stackTrace) {
                  //   print("Error ${error.toString()}");
                  // });
                }),
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
    restaurantImage = await picker.pickImage(source: ImageSource.gallery);
    print(restaurantImage);
    if (restaurantImage == null)
      return; //yedi image null xa vane or user le image select gareko xaina vane tye bata rokera bahira jane
    file = File(restaurantImage!.path); //image ko path liyeko
    setState(() {
      file;
      restaurantImage; //file and image dubai aaye paxi dubai lai aru thau ma notify garnu xa tyesaile
    });
  }
}
