// import 'package:firebase1/util/string_const.dart';
import 'package:flutter/material.dart';

class DeliverTo extends StatefulWidget {
  const DeliverTo({super.key});

  @override
  State<DeliverTo> createState() => DeliverToState();
}

class DeliverToState extends State<DeliverTo> {
  @override
  Widget build(BuildContext context) {
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
                        "Enter Delivery Address",
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
                          ),
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
                          )
                        ],
                      ),
                        SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "City:",
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
                
                }, child: Text("Proceed",style: TextStyle(fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
