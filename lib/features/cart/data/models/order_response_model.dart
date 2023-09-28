class OrderResponseModel {
  String? message;
  OrderResponseModel({this.message});
  OrderResponseModel.fromMap(Map<String, dynamic> map) {
    message = map['json'];
  }
}
