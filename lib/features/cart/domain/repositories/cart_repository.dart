import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/features/cart/data/models/address_response_model.dart';
import 'package:caredoot/features/cart/data/models/cart_response_model.dart';
import 'package:caredoot/features/cart/data/models/coupon_response_model.dart';
import 'package:caredoot/features/cart/data/models/order_response_model.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/features/cart/domain/entities/coupon_entity.dart';
import 'package:caredoot/features/cart/domain/entities/delete_entity.dart';
import 'package:caredoot/features/cart/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepository {
  Future<Either<Failure, CartResponseModel>> getCart();
  Future<Either<Failure, NoParams>> deleteItemFromCart(DeleteItemEntity entity);
  Future<Either<Failure, CouponResponseModel>> getCoupon(CouponEntity entity);
  Future<Either<Failure, AddressResponseModel>> saveAddress(Address entity);
  Future<Either<Failure, List<Address>>> getAllAddresses(NoParams params);
  Future<Either<Failure, OrderResponseModel>> placeOrder(OrderEntity entity);
}
