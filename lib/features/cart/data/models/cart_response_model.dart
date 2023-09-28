import 'dart:convert';

import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CartResponseModel extends Equatable {
  String userKey;
  List<CartItemModel> items;
  CartResponseModel({
    required this.userKey,
    required this.items,
  });
  Map<String, dynamic> toMap() {
    return {
      'userKey': userKey,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory CartResponseModel.fromMap(Map<String, dynamic> map) {
    return CartResponseModel(
      userKey: map['userKey'] ?? '',
      items: List<CartItemModel>.from(
          map['data']?.map((x) => CartItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartResponseModel.fromJson(String source) =>
      CartResponseModel.fromMap(json.decode(source));

  @override
  String toString() => 'CartResponseModel(userKey: $userKey, items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartResponseModel &&
        other.userKey == userKey &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => userKey.hashCode ^ items.hashCode;

  @override
  List<Object?> get props => [userKey, items];
}
