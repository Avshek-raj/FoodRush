class OrderModel{
  String? orderId;
  String? orderImage;
      String? userImage;
  String? orderPrice;
      String? orderName;
  int? orderQuantity;
      String? userName;
  String? userId;
      String? restaurantId;
      String? userAddress;
      String? deliveryLatLng;
      String? payment;
  OrderModel({this.payment ,this.deliveryLatLng, this.orderImage,this.userAddress, this.orderId,this.userImage,this.orderPrice,this.orderName,this.orderQuantity, this.userName, this.userId, this.restaurantId});
}