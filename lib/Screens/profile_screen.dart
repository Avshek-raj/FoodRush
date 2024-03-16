import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/login/loginAs.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import 'deliverto.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
            child: Row(
              children: [
                Text(
                  "MY PROFILE",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Spacer(),
                IconButton(
                  onPressed: () async{
                    await FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginAs())));
                  },
                  icon: Icon(Icons.exit_to_app),)
              ],
            ),
          ),
          Divider(),
          Container(
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.grey),
                // borderRadius: BorderRadius.circular(10)
                ),
            child: Column(
              children: [
                SizedBox(height: 30),
                CircleAvatar(
                  child: Icon(
                    Icons.person_outline,
                    size: 40,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors
                      .red, // Optional: you can set the background color of the avatar
                  radius: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  userProvider.userModel.username?? 'Username',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email_sharp),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        userProvider.userModel.email??
                        "Email"
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.red,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 13),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //next wala
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              child: Column(
                children: [
                  profileMenuItem ("My Favourites",Icon(Icons.favorite), context, ""),

                  Divider(),
                  profileMenuItem ("Order History",Icon(Icons.history), context, ""),
                  Divider(),
                  profileMenuItem ( "Delivery Address",Icon(Icons.my_location), context, DeliverTo()),
                  Divider(),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

GestureDetector profileMenuItem( String menuName, Icon icon, BuildContext context, function){
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => function));
    },
    child: Row(
      children: [
        Container(
          height: 40,
          width: 28,
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey.shade100),
          //   borderRadius: BorderRadius.circular(10)
          // ),
          child: icon,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          menuName,
          style: TextStyle(color: Colors.grey.shade800),
        )
      ],
    ),
  );
}

// Row profileMenuItem (menuName,Icon icon){
//   return Row(
//     children: [
//       Container(
//         height: 40,
//         width: 28,
//         // decoration: BoxDecoration(
//         //   border: Border.all(color: Colors.grey.shade100),
//         //   borderRadius: BorderRadius.circular(10)
//         // ),
//         child: icon,
//       ),
//       SizedBox(
//         width: 15,
//       ),
//       Text(
//         menuName,
//         style: TextStyle(color: Colors.grey.shade800),
//       )
//     ],
//   );
// }