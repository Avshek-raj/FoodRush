import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import 'order_provider.dart';

class MessageProvider with ChangeNotifier{
  late OrderProvider orderProvider;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void setupFirebaseMessaging(BuildContext context,String? role) {
    orderProvider = Provider.of(context, listen: false);

    _firebaseMessaging.getToken().then((token) {
      print('Firebase Token: $token');
        setMessageToken(context, token!, role);
      // Send this token to your server to associate it with the user
    });



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('New message: ${message.notification?.title}');
      String user = message.data['custom_data']['username'];
      String orders = message.data['custom_data']['orders'];
      String userImage = message.data['custom_data']['userImage'];
      String userId = message.data['custom_data']['user_id'];
      orderProvider.addOrderList(userId: userId, user: user, userImage: userImage, order: orders);
      // Display notification or handle the message as needed
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from background: ${message.notification?.title}');
      // Handle the message when the app is opened from the background
    });
  }

  void sendNotificationToUser(String receiverToken, String title, String body, String orders, UserModel userModel) async {
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
          'custom_data': {
            'user_id': FirebaseAuth.instance.currentUser?.uid,
            'username': userModel.username,
            'userImage': userModel.userImage,
            'orders': orders,
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

  void setMessageToken (BuildContext context, String token, String? role) async{
    try {
      await FirebaseFirestore.instance
          .collection("${role}Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(role=="Restaurant" ? "${role}Info" : "Info")
          .doc("MessageToken")
          .set({
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
