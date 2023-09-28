import 'dart:convert';

import 'package:caredoot/core/apis/base/custom_http_client.dart';
import 'package:caredoot/core/constants/url_constants.dart';
import 'package:caredoot/core/error/exception.dart';
import 'package:caredoot/core/helpers/shopping_cart_helper.dart';
import 'package:caredoot/core/helpers/user_helpers.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/cart/data/models/address_response_model.dart';
import 'package:caredoot/features/cart/data/models/cart_response_model.dart';
import 'package:caredoot/features/cart/data/models/coupon_response_model.dart';
import 'package:caredoot/features/cart/data/models/order_response_model.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/features/cart/domain/entities/coupon_entity.dart';
import 'package:caredoot/features/cart/domain/entities/order_entity.dart';
import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:caredoot/main.dart';

abstract class CartDataSource {
  Future<CartResponseModel> getCart();
  Future<CartResponseModel> updateCart();
  Future<CouponResponseModel> getCouponDiscount(CouponEntity entity);
  Future<AddressResponseModel> saveAddress(Address entity);
  Future<AddressResponseModel> updateAddress(AddressEntity entity);
  Future<List<Address>> getAllAddresses();
  Future<OrderResponseModel> placeOrder(OrderEntity entity);
}

class CartDataSourceImpl extends CartDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();

  @override
  Future<CartResponseModel> getCart() async {
    cart.clear();

    //Checking if the user is logged In
    bool userStatus = await UserHelpers.getUserDetails() != false;
    if (userStatus) {
      var user = await UserHelpers.getUserDetails();
      print("=====================Get Cart ===============");
      final response = await customHttpClient.get(
        Uri.parse("$GET_CART/${user.userKey}"),
      );
      Utils.printJson(response.body);
      if (response.statusCode == 200) {
        return CartResponseModel.fromJson(response.body);
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        throw ApiException(message: json.decode(response.body)["msg"]);
      } else {
        throw ServerException();
      }
    } else {
      List<CartItem> cartItems = await ShoppingCartHelper.getCart();
      List<CartItemModel> items =
          cartItems.map((e) => CartItemModel.fromMap(e.toMap())).toList();
      cart.addAll(items);
      return CartResponseModel(userKey: "key", items: items);
    }
  }

  @override
  Future<CartResponseModel> updateCart() {
    // TODO: implement updateCart
    throw UnimplementedError();
  }

  @override
  Future<CouponResponseModel> getCouponDiscount(CouponEntity entity) async {
    print("=====================Coupon Init ===============");
    final response = await customHttpClient.get(
      Uri.parse(
        '$COUPON/${entity.couponCode}',
      ),
    );
    Utils.printJson(response.body);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      return CouponResponseModel.fromMap(result);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddressResponseModel> updateAddress(AddressEntity entity) async {
    print("=====================Coupon Init ===============");
    final response = await customHttpClient.put(
        Uri.parse(UserAddress), jsonEncode(entity.toMap()));
    Utils.printJson(response.body);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      return AddressResponseModel.fromMap(result);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddressResponseModel> saveAddress(Address entity) async {
    print("=====================Save Address ===============");
    final response = await customHttpClient.post(
        Uri.parse(UserAddress), jsonEncode(entity.toMap()));
    Utils.printJson(response.body);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      return AddressResponseModel.fromMap(result);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Address>> getAllAddresses() async {
    List<Address> addresses = [];
    var user = await UserHelpers.getUserDetails();
    print("=====================Get All Addresses ===============");
    String url = "$UserAddress/${user.userKey}";
    final response = await customHttpClient.get(Uri.parse(url));
    if (response.body.isNotEmpty) {
      Utils.printJson(response.body);
    } else {
      print("Error occured");
    }

    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      if (body['data'] != null && body['data'].isNotEmpty) {
        for (var add in body['data']) {
          addresses.add(Address.fromMap(add));
        }
      }
      return addresses;
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrderResponseModel> placeOrder(OrderEntity entity) async {
    print("=====================Place Order ===============");
    final response = await customHttpClient.post(
        Uri.parse(UserAddress), jsonEncode(entity.toJson()));
    Utils.printJson(response.body);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      return OrderResponseModel.fromMap(result);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }
}
