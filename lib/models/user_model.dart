import 'location_model.dart';

class UserModel {
  String? username;
  String? email;
  String? address;
  String? phone;
  String? password;
  List<DeliveryInfoModel>? deliveryInfo;
  UserModel({this.username,this.email,this.address,this.phone,this.password, this.deliveryInfo});
}