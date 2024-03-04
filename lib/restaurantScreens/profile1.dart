import 'package:flutter/material.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
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
                            // backgroundImage: NetworkImage(
                            //     " https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8u9rnEzITf3Kzpe_5YIEz4Z0RPb2vxe2ySlTG8uc&ss"),
                            radius: 20,
                            child: 
                            // Text(
                            //   "SS",
                            //   style:
                            //       TextStyle(color: Colors.white, fontSize: 23),
                            // ),
                            Icon(Icons.person_outlined,color: Colors.red,size: 30,),
                            backgroundColor: Colors.grey.shade200,
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
                  child: Text("Lahana Newari Khaja Ghar",style: TextStyle(fontWeight: FontWeight.w500),),
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
            ],
          ),
        ),
      ),
    );
  }
}
