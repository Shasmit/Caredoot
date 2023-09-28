import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddToCartModel extends Equatable {
  String msg;
  AddToCartModel({
    required this.msg,
  });

  AddToCartModel copyWith({
    String? msg,
  }) {
    return AddToCartModel(
      msg: msg ?? this.msg,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      msg: map['msg'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartModel.fromJson(String source) =>
      AddToCartModel.fromMap(json.decode(source));

  @override
  String toString() => 'AddToCartModel(msg: $msg)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddToCartModel && other.msg == msg;
  }

  @override
  int get hashCode => msg.hashCode;

  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}
