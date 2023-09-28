import 'dart:convert';

import 'package:flutter/foundation.dart';

class ServiceResponseModel {
  List<ServiceModel> services;
  ServiceResponseModel({
    required this.services,
  });

  ServiceResponseModel copyWith({
    List<ServiceModel>? services,
  }) {
    return ServiceResponseModel(
      services: services ?? this.services,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'services': services.map((x) => x.toMap()).toList(),
    };
  }

  factory ServiceResponseModel.fromMap(Map<String, dynamic> map) {
    return ServiceResponseModel(
      services: List<ServiceModel>.from(
          map['data']?.map((x) => ServiceModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceResponseModel.fromJson(String source) =>
      ServiceResponseModel.fromMap(json.decode(source));

  @override
  String toString() => 'ServiceResponseModel(services: $services)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceResponseModel &&
        listEquals(other.services, services);
  }

  @override
  int get hashCode => services.hashCode;
}

class ServiceModel {
  String name;
  String icon;
  String slug;
  ServiceModel({
    required this.name,
    required this.icon,
    required this.slug,
  });

  ServiceModel copyWith({
    String? name,
    String? icon,
    String? slug,
  }) {
    return ServiceModel(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'slug': slug,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source));

  @override
  String toString() => 'ServiceModel(name: $name, icon: $icon, slug: $slug)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceModel &&
        other.name == name &&
        other.icon == icon &&
        other.slug == slug;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ slug.hashCode;
}
