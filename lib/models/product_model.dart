class ProductModel {
  String productId;
  String productName;
  String productImage;
  String productPrice;
  String productDesc;
  String restaurantId;
  String restaurantName;
  double? distance;
  String? restaurantLatLng;
  double? rating;
  ProductModel(
      {
      required this.productId,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productDesc,
      required this.restaurantId,
      required this.restaurantName,
      this.distance,
      this.restaurantLatLng,
        this.rating,
      });
}
