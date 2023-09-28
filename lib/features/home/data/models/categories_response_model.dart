import 'dart:convert';

import 'package:flutter/foundation.dart';

class CategoriesResponseModel {
  List<CategoryModel> categories;
  CategoriesResponseModel({
    required this.categories,
  });

  CategoriesResponseModel copyWith({
    List<CategoryModel>? categories,
  }) {
    return CategoriesResponseModel(
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoriesResponseModel.fromMap(Map<String, dynamic> map) {
    return CategoriesResponseModel(
      categories: List<CategoryModel>.from(
          map['data']?.map((x) => CategoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesResponseModel.fromJson(String source) =>
      CategoriesResponseModel.fromMap(json.decode(source));

  @override
  String toString() => 'CategoriesResponseModel(categories: $categories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoriesResponseModel &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode => categories.hashCode;
}

class CategoryModel {
  String name;
  String icon;
  String slug;
  CategoryModel({
    required this.name,
    required this.icon,
    required this.slug,
  });

  CategoryModel copyWith({
    String? name,
    String? icon,
    String? slug,
  }) {
    return CategoryModel(
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

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryModel(name: $name, icon: $icon, slug: $slug)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.name == name &&
        other.icon == icon &&
        other.slug == slug;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ slug.hashCode;
}
