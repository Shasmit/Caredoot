part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadedState extends CartState {
  final CartResponseModel cart;
  const CartLoadedState(this.cart);
  @override
  List<Object> get props => [cart];
}

class CartLoadingState extends CartState {}

class CartFailureState extends CartState {
  final String errorMessage;
  const CartFailureState(this.errorMessage);
}

class CartRefereshedState extends CartState {
  final CartResponseModel cartResponseModel;
  const CartRefereshedState({required this.cartResponseModel});
  @override
  List<Object> get props => [cartResponseModel];
}

//=====================Coupon====================

class CouponLoadingState extends CartState {
  const CouponLoadingState();
}

class CouponSuccessState extends CartState {
  final CouponResponseModel couponResponseModel;
  @override
  List<Object> get props => [couponResponseModel];
  const CouponSuccessState(this.couponResponseModel);
}

class CouponFailureState extends CartState {
  final String errorMessage;

  const CouponFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class RemoveCouponState extends CartState {}

class UpdateDefaultAddressCheckBoxState extends CartState {
  final bool value;
  const UpdateDefaultAddressCheckBoxState(this.value);
  @override
  List<Object> get props => [value];
}

class AddressSavedState extends CartState {
  final AddressResponseModel response;
  const AddressSavedState(this.response);
}

class AddressesLoadedState extends CartState {
  final List<Address> addresses;
  const AddressesLoadedState(this.addresses);
}

class AddressSaveFailureState extends CartState {}

class CartRefreshedState extends CartState {}

class CartRefreshFailureState extends CartState {}

class OrderPlacedSuccessState extends CartState {
  final OrderResponseModel response;
  const OrderPlacedSuccessState(this.response);
}
