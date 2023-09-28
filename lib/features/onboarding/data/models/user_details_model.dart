// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDetails {
  final String? name;
  final int? age;
  final String? profileImageUrl;
  final String? gender;
  final String? phone;
  final String? email;
  final String? currentLocation;
  final String? coins;

  final String? userKey;

  final bool? isWorking;
  UserDetails(
      {this.name,
      this.age,
      this.gender,
      this.phone,
      this.email,
      this.currentLocation,
      this.coins,
      this.profileImageUrl,
      this.isWorking,
      this.userKey});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'gender': gender,
      'phone': phone,
      'email': email,
      'currentLocation': currentLocation,
      'photo': profileImageUrl,
      'coins': coins,
      'isWorking': isWorking ?? false,
      'key': userKey
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
        gender: map['gender'] != null ? map['gender'] as String : null,
        name: map['name'],
        phone: map['phone'] != null ? map['phone'] as String : null,
        email: map['email'] != null ? map['email'] as String : null,
        isWorking: map['isWorking'] ?? false,
        profileImageUrl: map['photo'],
        currentLocation: map['currentLocation'] != null
            ? map['currentLocation'] as String
            : null,
        coins: map['coins'] != null ? map['coins']!.toString() : null,
        userKey: map['key']);
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
