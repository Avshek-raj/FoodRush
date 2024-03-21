import 'location_model.dart';

class UserModel {
  String? username;
  String? email;
  String? address;
  String? phone;
  String? password;
  String? role;
  String? userImage;
  List<DeliveryInfoModel>? deliveryInfo;
  String? token;
  String? userLatLng;
  UserModel({this.username,this.email,this.address,this.phone,this.password, this.role, this.deliveryInfo, this.token, this.userImage, this.userLatLng});
}