import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:provider/provider.dart'; // Import Services

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
        UserProvider userProvider = Provider.of<UserProvider>(context);

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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 18, 18, 18),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red, // Optional: Set the background color of the avatar
                    child: ClipOval(
                      child: Image.network(
                        userProvider.userModel.userImage ?? "", // Provide the image URL
                        fit: BoxFit.cover,
                      ),
                    ),
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
