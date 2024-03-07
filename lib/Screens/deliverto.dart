import 'package:flutter/material.dart';
import 'package:foodrush/Screens/mainScreen.dart';
import 'package:foodrush/providers/delivery_provider.dart';

import 'package:foodrush/reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import '../models/location_model.dart';
import '../providers/user_provider.dart';
import '../reusable_widgets/reusable_widget.dart';


class DeliverTo extends StatefulWidget {
  const DeliverTo({super.key});

  @override
  State<DeliverTo> createState() => DeliverToState();
}

class DeliverToState extends State<DeliverTo> {
  DeliveryProvider deliveryProvider = DeliveryProvider();
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController landmark = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    name.text = userProvider.deliveryInfoModel.name!;
    address.text = userProvider.deliveryInfoModel.address!;
    landmark.text = userProvider.deliveryInfoModel.landmark!;
    phone.text = userProvider.deliveryInfoModel.phone!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(
                    color: Colors.black,
                  ), //back jane button
                  Spacer(),
                  Text(
                    "Deliver to",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Icon(
                        Icons.question_mark,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              //form ko lagi container
              Container(
                height: 280,
                width: 360,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12,),
                      Text(
                        "Enter Delivery Info",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                             "Name:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: name,

                            )
                          )
                        ],
                      ),
                        SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Address:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                              child: TextField(
                                controller: address,
                              )
                          )
                        ],
                      ),
                        SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                             "Landmark:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                              child: TextField(
                                controller: landmark,
                              )
                          )
                        ],
                      ),
                        SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                              child: TextField(
                                controller: phone,
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(
                        height: 50,
                      ),
              //proceed button
              SizedBox(
                 height: 50,
                 width: 250,
                child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary:Colors.red,
                        ),
                  onPressed: (){
                    deliveryProvider.addDeliveryData(context: context, name: name.text, address: address.text, landmark: landmark.text, phone: phone.text, onSuccess: () {
                      Navigator.pop(context);
                      // Execute any additional code on success
                    },
                    onError: (error) {
                    print('Failed to add product: $error');
                    // Execute any additional code on error
                    },
                    );
                  }, child: Text("Proceed",style: TextStyle(fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
