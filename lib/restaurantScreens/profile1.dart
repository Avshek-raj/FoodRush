import 'package:flutter/material.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/ui_custom/customElevatedButton.dart';
import 'package:foodrush/utils/color_utils.dart';

class ProfileRestaurant extends StatefulWidget {
  const ProfileRestaurant({super.key});

  @override
  State<ProfileRestaurant> createState() => _ProfileRestaurantState();
}

class _ProfileRestaurantState extends State<ProfileRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              //container for restaurant to upload their photo
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width * 0.99,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade800,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          14),
                                      child: Image.asset(
                                      "assets/images/deliveryPhoto.png" ,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                    // alignment: Alignment.center,
                    
                  ),
                  Row(
                    children: [
                      //container for dp
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              )),
                          child: CircleAvatar(
  // Icon(Icons.person_outlined,color: Colors.red,size: 30,),
                            // backgroundColor: Colors.grey.shade200,              
    radius: 35,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: Image.asset(
        "assets/images/newalahana.png",
        fit: BoxFit.cover,
      ),
    ),

                          ),
                        ),
                      ),
                      //for text
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Text(
              //                   "Hello Samjhana,",
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.w500,
              //                       color: Colors.black,
              //                       fontSize: 16),
              //                 ),
              //                 Text(
              //                   "Welcome to Food Rush",
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.w500,
              //                       color: Colors.black,
              //                       fontSize: 16),
              //                 ),
              //                 Divider(),
              Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  children: [
                Icon(Icons.local_dining_outlined, color: Colors.red,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Restaurant Name",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                Spacer(),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Newa Lahana",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                  ],
                ),
              ),
              Divider(),
                  Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  children: [
                Icon(Icons.location_on_outlined, color: Colors.red,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Address",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                Spacer(),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Banepa, Ram-Mandir",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                  ],
                ),
              ),
              Divider(),
                    Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  children: [
                Icon(Icons.email_outlined, color: Colors.red,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                Spacer(),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Lahana234@gmail.com",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                  ],
                ),
              ),
              Divider(),
                    Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  children: [
                Icon(Icons.phone, color: Colors.red,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Phone",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                Spacer(),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("+977 9823231250",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 50,
              ),
              //log out button

                   CustomElevatedButton(
                onPressed: () {
                  // Show the logout confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm Logout",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
                        content: Text("Are you sure you want to log out?",style:TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                        actions: <Widget>[
                          // Button to logout
                          ElevatedButton(
                               style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                           
                              // Perform logout actions
                              // For example, you can navigate to the login screen or clear user data
                              Navigator.of(context).pop(); // Close the dialog
                              // Call the logout function
                              logoutUser();
                            },
                            child: Text("Yes"),
                          ),
                          // Button to cancel logout
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Log Out",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void logoutUser() {
    // Perform the logout action here
    // For example, you can navigate to the login screen or clear user data
    print("User logged out");
  }
