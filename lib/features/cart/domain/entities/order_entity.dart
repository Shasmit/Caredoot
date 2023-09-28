class OrderEntity {
  String? addressId;
  String? workdate;
  String? total;
  String? discount;
  String? discountCoupon;
  String? gst;
  int? pointRedeem;
  String? totalPayment;
  String? paymentMode;
  String? razorPayId;
  String? userKey;

  OrderEntity(
      {this.addressId,
      this.workdate,
      this.total,
      this.discount,
      this.discountCoupon,
      this.gst,
      this.pointRedeem,
      this.totalPayment,
      this.paymentMode,
      this.razorPayId,
      this.userKey});

  OrderEntity.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    workdate = json['workdate'];
    total = json['total'];
    discount = json['discount'];
    discountCoupon = json['discount_coupon'];
    gst = json['gst'];
    pointRedeem = json['point_redeem'];
    totalPayment = json['total_payment'];
    paymentMode = json['payment_mode'];
    razorPayId = json['razorPayId'];
    userKey = json['user_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['workdate'] = workdate;
    data['total'] = total;
    data['discount'] = discount;
    data['discount_coupon'] = discountCoupon;
    data['gst'] = gst;
    data['point_redeem'] = pointRedeem;
    data['total_payment'] = totalPayment;
    data['payment_mode'] = paymentMode;
    data['razorPayId'] = razorPayId;
    data['user_key'] = userKey;
    return data;
  }
}
