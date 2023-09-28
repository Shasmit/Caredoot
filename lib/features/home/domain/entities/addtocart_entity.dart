import 'dart:convert';

import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:equatable/equatable.dart';

class AddToCartEntity extends Equatable {
  final List<CartItemModel> cartData;
  final String? userKey;
  final isFromBackTap;

  const AddToCartEntity(
      {required this.cartData, this.userKey, this.isFromBackTap = false});

  AddToCartEntity copyWith({
    List<CartItemModel>? cartData,
  }) {
    return AddToCartEntity(
        cartData: cartData ?? this.cartData, userKey: userKey);
  }

  Map<String, dynamic> toMap() {
    return {
      'cart_data': cartData.map((x) => x.toMap()).toList(),
      'user_key': userKey
    };
  }

  factory AddToCartEntity.fromMap(Map<String, dynamic> map) {
    return AddToCartEntity(
      cartData: List<CartItemModel>.from(
          map['cart_data']?.map((x) => CartItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartEntity.fromJson(String source) =>
      AddToCartEntity.fromMap(json.decode(source));

  @override
  List<Object?> get props => [cartData, userKey];
}
