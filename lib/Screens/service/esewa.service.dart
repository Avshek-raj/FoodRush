
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/mainScreen.dart';
import 'package:foodrush/models/cart_model.dart';

import '../../providers/cart_provider.dart';

const String kEsewaClientId =
    'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';
const String kEsewaSecretKey = 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';

class Esewa {
  late CartProvider cartProvider;
  Esewa(this.cartProvider);
  pay(BuildContext context, String price, String productId, String productName, List<CartModel> cartList) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: kEsewaClientId,
          secretId: kEsewaSecretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: productId,
          productName: productName,
          productPrice: price, callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
          verifyTransactionStatus(context, data, cartList);
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }

  void verifyTransactionStatus(BuildContext context, EsewaPaymentSuccessResult result, List<CartModel> cartList) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        for (var item in cartList){
          cartProvider.deleteCartItem(item.cartId);
        }
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: Text("Payment Successful")),
          content: Column(
            mainAxisSize: MainAxisSize.min, // To minimize the dialog size
            children: [
              Image.asset(
                'assets/images/success.png',
                fit: BoxFit.fill,// Provide the correct asset path here
                width: 80, // Adjust the width as needed
                height: 80, // Adjust the height as needed
              ),
              SizedBox(height: 8),
              Text(
                "Your food has been ordered and will be delivered shortly by the restaurant.",
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(
                  "Thank you for ordering with us.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())); // Close dialog
              },
            ),
          ],
        );
      },
    );
    // var response = await callVerificationApi(result);
    // if (response.statusCode == 200) {
    //   var map = {'data': response.data};
    //   final sucResponse = EsewaPaymentSuccessResponse.fromJson(map);
    //   debugPrint("Response Code => ${sucResponse.data}");
    //   if (sucResponse.data[0].transactionDetails.status == 'COMPLETE') {
    //     //TODO Handle Txn Verification Success
    //     return;
    //   }
    //   //TODO Handle Txn Verification Failure
    // } else {
    //   //TODO Handle Txn Verification Failure
    // }
  }
}