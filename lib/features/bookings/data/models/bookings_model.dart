class OrderModel {
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
  String? status;

  OrderModel(
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
      this.status});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
    status = json['user_key'];
  }
}
