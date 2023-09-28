import 'dart:convert';

import 'package:flutter/foundation.dart';

class SubCategoryResponseModel {
  List<SubCategoryModel> subcategories;
  SubCategoryResponseModel({
    required this.subcategories,
  });

  SubCategoryResponseModel copyWith({
    List<SubCategoryModel>? subcategories,
  }) {
    return SubCategoryResponseModel(
      subcategories: subcategories ?? this.subcategories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subcategories': subcategories.map((x) => x.toMap()).toList(),
    };
  }

  factory SubCategoryResponseModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryResponseModel(
      subcategories: List<SubCategoryModel>.from(
          map['data']?.map((x) => SubCategoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryResponseModel.fromJson(String source) =>
      SubCategoryResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SubCategoryResponseModel(subcategories: $subcategories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubCategoryResponseModel &&
        listEquals(other.subcategories, subcategories);
  }

  @override
  int get hashCode => subcategories.hashCode;
}

class SubCategoryModel {
  String name;
  String icon;
  String slug;
  SubCategoryModel({
    required this.name,
    required this.icon,
    required this.slug,
  });

  SubCategoryModel copyWith({
    String? name,
    String? icon,
    String? slug,
  }) {
    return SubCategoryModel(
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

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryModel.fromJson(String source) =>
      SubCategoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SubCategoryModel(name: $name, icon: $icon, slug: $slug)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubCategoryModel &&
        other.name == name &&
        other.icon == icon &&
        other.slug == slug;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ slug.hashCode;
}
