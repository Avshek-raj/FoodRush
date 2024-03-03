// import 'package:firebase1/util/string_const.dart';
import 'package:flutter/material.dart';
// import 'package:text_divider/text_divider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool selectedValue = true; // or whatever initial value you want

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(
                    color: Colors.black,
                  ), //back jane button
                  Spacer(),
                  Text(
                    "Payment",
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
                height: 15,
              ),
              Text(
                "Choose your payment method",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  "aset/images/esewa.png",
                  fit: BoxFit.contain,
                ),

                // child: Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Column(
                //         children: [
                //           Container(
                //              height: 90,
                //                   width: 90,
                //                   decoration: BoxDecoration(
                //                       // shape: BoxShape.rectangle,
                //                       color: Colors.white,
                //                       border: Border.all(color: Colors.grey.shade200),
                //                       borderRadius: BorderRadius.circular(10)),
                //             child: Image.asset("aset/images/esewa.png",
                //              height: 40,
                //                     width: 40,
                //                     fit: BoxFit.contain,

                //             )
                //             ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ),
              Text(
                "eSewa",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              // TextDivider.horizontal(
              //     text: const Text(
              //   'OR',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              // )),
              Row(
    children: <Widget>[
        Expanded(
            child: Divider()
        ),       

        Text("OR"),        

        Expanded(
            child: Divider()
        ),
    ]
),
              SizedBox(
                height: 15,
              ),
              //container for cash on delivery
              Container(
                height: 90,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cash on delivery",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "(Pay with cash or POS on delivery)",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ]),
                      Spacer(),
                      Radio(
                        value: false, // value for the radio button
                        groupValue:
                            selectedValue, // selected value of the group
                        onChanged: (value) {
                          // handle onChanged event here
                          setState(() {
                            selectedValue=value!;
                          },);
                        },
                        activeColor: Colors.red,
                      ),

                      // Icon(Icons.circle,color: myColor,),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //Elevated button
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.red,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Complete Order",
                      style: TextStyle(fontSize: 15),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
