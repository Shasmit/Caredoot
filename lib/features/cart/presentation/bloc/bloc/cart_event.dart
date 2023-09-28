part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInit extends CartEvent {}

class DeleteItemFromCartEvent extends CartEvent {
  final DeleteItemEntity entity;
  const DeleteItemFromCartEvent({required this.entity});
}

class QuantityUpdateEvent extends CartEvent {
  final QtyUpdateEntity entity;
  const QuantityUpdateEvent({required this.entity});
}

class GetCouponDiscountEvent extends CartEvent {
  final CouponEntity entity;

  const GetCouponDiscountEvent(this.entity);
}

class CouponRemoveEvent extends CartEvent {}

class UpdateCartEvent extends CartEvent {}

class UpdateDefaultAddressCheckBoxEvent extends CartEvent {
  final bool value;
  const UpdateDefaultAddressCheckBoxEvent({required this.value});
  @override
  List<Object> get props => [value];
}

class SaveAddressEvent extends CartEvent {
  final Address addressEntity;
  const SaveAddressEvent({required this.addressEntity});
}

class GetMyAddressesEvent extends CartEvent {}

class RefreshCartEvent extends CartEvent {}

class ProcessCODPaymentEvent extends CartEvent {
  final OrderEntity entity;
  const ProcessCODPaymentEvent({required this.entity});
}
