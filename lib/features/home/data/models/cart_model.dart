import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  late String itemId;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late int amount;
  @HiveField(3)
  late int qty;
  @HiveField(4)
  late String image;
  CartItem(
      {required this.itemId,
      required this.name,
      required this.amount,
      required this.qty,
      required this.image});

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'name': name,
      'amount': amount,
      'qty': qty,
      'slider_1': image
    };
  }
}

class Cart {
  List<CartItemModel> items;
  String userKey;
  Cart({
    required this.items,
    required this.userKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'cart_data': items.map((x) => x.toMap()).toList(),
      'user_key': userKey,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      items: List<CartItemModel>.from(
          map['cart_data']?.map((x) => CartItemModel.fromMap(x))),
      userKey: map['user_key'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}

class CartItemModel extends Equatable {
  String itemId;
  String name;
  int amount;
  int qty;
  String image;
  CartItemModel(
      {required this.itemId,
      required this.name,
      required this.amount,
      required this.qty,
      required this.image});

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'name': name,
      'amount': amount,
      'qty': qty,
      'slider_1': image
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
        itemId: map['item_id'].toString(),
        name: map['name'] ?? '',
        amount: map['amount'] is String
            ? int.parse(map['amount']).toInt()
            : map['amount'] ?? 0,
        qty: map['qty']?.toInt() ?? 0,
        image: map['slider_1']);
    //map['slider_1']);
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));

  @override
  // TODO: implement props
  List<Object?> get props => [qty, amount, image, itemId];
}
