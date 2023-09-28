import 'dart:convert';

class AddressEntity {
  final Address address;
  final String userKey;
  const AddressEntity(
    this.address,
    this.userKey,
  );

  AddressEntity copyWith({
    Address? address,
    String? userKey,
  }) {
    return AddressEntity(
      address ?? this.address,
      userKey ?? this.userKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address_data': address.toMap(),
      'user_key': userKey,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      Address.fromMap(map['address']),
      map['userKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) =>
      AddressEntity.fromMap(json.decode(source));

  @override
  String toString() => 'AddressEntity(address: $address, userKey: $userKey)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressEntity &&
        other.address == address &&
        other.userKey == userKey;
  }

  @override
  int get hashCode => address.hashCode ^ userKey.hashCode;
}

class Address {
  String? mobile;
  String? id;
  String? name;
  String? address;
  String? pincode;
  String? email;
  bool? isDefault;
  String? userKey;

  Address(
      {this.mobile,
      this.id,
      this.name,
      this.address,
      this.pincode,
      this.email,
      this.isDefault,
      this.userKey});

  Map<String, dynamic> toMap() {
    return {
      'address_mobile': int.parse(mobile ?? "0"),
      'name': name,
      'address': address,
      'pincode': int.parse(pincode ?? "0"),
      'id': id,
      'email': email,
      'isDefault': "Yes",
      'user_key': userKey
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
        mobile: map['mobile'],
        id: map['id'],
        name: map['name'],
        address: map['address'],
        pincode: map['pincode'].toString(),
        email: map['email'],
        isDefault: map['isDefault'] != null
            ? map['isDefault'].toString().toLowerCase() == "yes"
                ? true
                : false
            : false,
        userKey: map['user_key']);
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(mobile: $mobile, id: $id, name: $name, address: $address, pincode: $pincode, email: $email, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.mobile == mobile &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.pincode == pincode &&
        other.email == email &&
        other.isDefault == isDefault;
  }

  @override
  int get hashCode {
    return mobile.hashCode ^
        id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        pincode.hashCode ^
        email.hashCode ^
        isDefault.hashCode;
  }
}
