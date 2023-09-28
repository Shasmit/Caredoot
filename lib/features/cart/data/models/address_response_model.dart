class AddressResponseModel {
  String? message;
  AddressResponseModel(this.message);
  AddressResponseModel.fromMap(dynamic map) {
    message = map['message'];
  }
}
