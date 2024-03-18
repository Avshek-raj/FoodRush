import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

import 'order_provider.dart';

class MessageProvider with ChangeNotifier{
  late OrderProvider orderProvider;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void setupFirebaseMessaging(BuildContext context) {
    orderProvider = Provider.of(context);

    _firebaseMessaging.getToken().then((token) {
      print('Firebase Token: $token');
        setMessageToken(context, token!);
      // Send this token to your server to associate it with the user
    });



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('wah message: ${message.notification?.title}');
      // Display notification or handle the message as needed
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from background: ${message.notification?.title}');
      // Handle the message when the app is opened from the background
    });
  }

  void sendNotificationToUser(String receiverToken, String title, String body) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAA5OFqZog:APA91bEqkRTFOB6L944XhdIbgKsTefB02WrrnBNiluj-0g-EtsDK3AE1sEGRX9vjRFc7wsw2LT3aud9jSZkw1O9uTE2DwH4YdUHqx4g-NyBCQ1JGRCcioyOntrBDuUe7gDnmvuO5eMiH',
      },
      body: jsonEncode(<String, dynamic>{
        'to': receiverToken,
        'notification': <String, dynamic>{
          'title': title,
          'body': body,
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'custom_data': {
            'user_id': '123',
            'order_id': '456',
          },
        },
      }),
    ).then((value) {
      print(value);

    }).onError((error, stackTrace) {
      print(error);
    });
    print("sucess");
  }

  void setMessageToken (BuildContext context, String token) async{
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("UserInfo")
         //.doc("MessageToken")
          .add({
        "Token": token,
      }).then((_) {
          print('Token uploaded Successfully');
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload token for messaging: $error'),
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload token: $e'),
      ));
    }
  }



}
