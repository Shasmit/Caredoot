import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: non_constant_identifier_names

class SubServiceResponseModel {
  List<SubServiceModel> subservices;
  SubServiceResponseModel({
    required this.subservices,
  });

  SubServiceResponseModel copyWith({
    List<SubServiceModel>? subservices,
  }) {
    return SubServiceResponseModel(
      subservices: subservices ?? this.subservices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subservices': subservices.map((x) => x.toMap()).toList(),
    };
  }

  factory SubServiceResponseModel.fromMap(Map<String, dynamic> map) {
    return SubServiceResponseModel(
      subservices: List<SubServiceModel>.from(
          map['data']?.map((x) => SubServiceModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubServiceResponseModel.fromJson(String source) =>
      SubServiceResponseModel.fromMap(json.decode(source));

  @override
  String toString() => 'SubServiceResponseModel(subservices: $subservices)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubServiceResponseModel &&
        listEquals(other.subservices, subservices);
  }

  @override
  int get hashCode => subservices.hashCode;
}

class SubServiceModel {
  String id;
  String name;
  String amount;
  String details;
  String slider_1;
  String estimate_time;
  SubServiceModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.details,
    required this.slider_1,
    required this.estimate_time,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'details': details,
      'slider_1': slider_1,
      'estimate_time': estimate_time,
    };
  }

  factory SubServiceModel.fromMap(Map<String, dynamic> map) {
    return SubServiceModel(
      name: map['name'] ?? '',
      id: map['id'],
      amount: map['amount'] ?? '',
      details: map['details'] ?? '',
      slider_1: map['slider_1'] ?? '',
      estimate_time: map['estimate_time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubServiceModel.fromJson(String source) =>
      SubServiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubServiceModel(name: $name, amount: $amount, details: $details, slider_1: $slider_1, estimate_time: $estimate_time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubServiceModel &&
        other.name == name &&
        other.amount == amount &&
        other.details == details &&
        other.slider_1 == slider_1 &&
        other.estimate_time == estimate_time;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        amount.hashCode ^
        details.hashCode ^
        slider_1.hashCode ^
        estimate_time.hashCode;
  }
}
