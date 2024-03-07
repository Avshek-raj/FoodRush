import 'package:flutter/material.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(width: 10,),
              // Spacer(),
              Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
            ],
                   ),
         ),
         //container for circle avatar
         Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              )),
          child: CircleAvatar(
            radius: 25,
                       child: Icon(Icons.person_outlined,color: Colors.red,size: 30,),
                            backgroundColor: Colors.transparent,
          ),
         ),
           //yo edit garne field haru
              SizedBox(
                height: 50,
              ),
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
                      return nameValidationStr;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                ),
              ),
                 SizedBox(
                height: 10,
              ),
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
                      return nameValidationStr;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: addressStr,
                  prefixIcon: Icon(
                    Icons.location_on,
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: emailStr,
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: phoneStr,
                  prefixIcon: Icon(
                    Icons.phone_iphone_rounded,
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
                height: 110,
              ), 
              SizedBox(
                height: 50,
                        width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                primary: Colors.red,
                  ),
                  onPressed: (){
                
                }, child: Text("Save")),
              ),  
        ],
        ),
      ),
    ),
   
    );
  }
}