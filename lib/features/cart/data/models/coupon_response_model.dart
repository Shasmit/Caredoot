class CouponResponseModel {
  CouponResponseModel({
    required this.msg,
    required this.data,
    required this.status,
  });
  late final String msg;
  late final CouponModel data;
  late final bool status;
  
  CouponResponseModel.fromMap(Map<String, dynamic> json){
    msg = json['msg'];
    data = CouponModel.fromJson(json['data']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    _data['status'] = status;
    return _data;
  }
}

class CouponModel {
  CouponModel({
    required this.discount,
  });
  late final String discount;
  
  CouponModel.fromJson(Map<String, dynamic> json){
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['discount'] = discount;
    return _data;
  }
}