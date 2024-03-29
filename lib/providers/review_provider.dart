import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewModal {
  String? productId;
  String? userName;
  String? userId;
  String? userImage;
  double? rating;
  String? review;
  String? date;
  ReviewModal({this.productId,this.userName,this.userId,this.userImage,this.rating, this.review, this.date});
}

class ReviewProvider with ChangeNotifier {
  void addReview({
    required BuildContext context, // Add required BuildContext parameter
    String? productId,
    String? userName,
    String? userId,
    String? userImage,
    double? rating,
    String? review,
    VoidCallback? onSuccess, // Callback for success
    Function(dynamic)? onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("Review")
          .doc(productId)
          .collection("ReviewList")
          .add({
        "ProductId": productId,
        "UserName": userName,
        "UserId": userId,
        "UserImage": userImage,
        "Rating": rating,
        "Review": review,
        "Date": DateTime.now(),
      }).then((_) {
        print('Review added successfully');
        if (onSuccess != null) onSuccess(); // Call success callback
      }).catchError((error) {
        print('Review add failed:$error');
        if (onError != null) onError(error); // Call error callback
      });
    } catch (e) {
      print('Review add failed:$e');
    }
  }

  List<ReviewModal> reviewList = [];
  late ReviewModal reviewModal;
  fetchReview(productId, callback) async{
    List<ReviewModal> newList = [];
    try {
      QuerySnapshot value = await FirebaseFirestore.instance.collection("Review")
          .doc(productId)
      .collection("ReviewList")
          .get();
      value.docs.forEach((element) {
        reviewModal = ReviewModal(
            productId: element.get("ProductId"),
            userName: element.get("UserName"),
            userId: element.get("UserId"),
            userImage: element.get("UserImage"),
            rating: element.get("Rating"),
            review: element.get("Review"),
        );
        newList.add(reviewModal);
      });
    } on Exception catch (e) {
      print(e);
    }
    reviewList = newList;
    callback();
    notifyListeners();
  }
}