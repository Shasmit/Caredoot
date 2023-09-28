import 'package:equatable/equatable.dart';

class CouponEntity extends Equatable {
  final String couponCode;

  const CouponEntity(this.couponCode);

  @override
  // TODO: implement props
  List<String> get props => [couponCode];
}
