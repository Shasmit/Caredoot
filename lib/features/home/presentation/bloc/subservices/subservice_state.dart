import 'package:caredoot/features/cart/data/models/cart_response_model.dart';
import 'package:caredoot/features/home/data/models/addtocart_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/sub_services_response_model.dart';

abstract class SubServiceState extends Equatable {
  const SubServiceState();

  @override
  List<Object> get props => [];
}

class SubServiceInitial extends SubServiceState {}

class SubServiceLoadingState extends SubServiceState {
  const SubServiceLoadingState();
}

class SubServiceSuccessState extends SubServiceState {
  final SubServiceResponseModel subServiceResponseModel;
  @override
  List<Object> get props => [subServiceResponseModel];
  const SubServiceSuccessState(this.subServiceResponseModel);
}

class SubServiceFailureState extends SubServiceState {
  final String errorMessage;

  const SubServiceFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class GetCartState extends SubServiceState {
  final CartResponseModel cart;
  const GetCartState(this.cart);
}

class GetCartFailureState extends SubServiceState {
  final String errorMessage;

  const GetCartFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class GetCartLoadingState extends SubServiceState {
  const GetCartLoadingState();
}

class AddedToCartState extends SubServiceState {
  final AddToCartModel response;
  const AddedToCartState({required this.response});
  @override
  List<Object> get props => [response];
}

class FlushState extends SubServiceState {}
