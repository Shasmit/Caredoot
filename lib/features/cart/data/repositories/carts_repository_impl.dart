import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/core/helpers/shopping_cart_helper.dart';
import 'package:caredoot/core/network/network_info.dart';
import 'package:caredoot/features/cart/data/datasources/carts_data_source.dart';
import 'package:caredoot/features/cart/data/models/address_response_model.dart';
import 'package:caredoot/features/cart/data/models/cart_response_model.dart';
import 'package:caredoot/features/cart/data/models/coupon_response_model.dart';
import 'package:caredoot/features/cart/data/models/order_response_model.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/features/cart/domain/entities/coupon_entity.dart';
import 'package:caredoot/features/cart/domain/entities/delete_entity.dart';
import 'package:caredoot/features/cart/domain/entities/order_entity.dart';
import 'package:caredoot/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';

class CartRepositoryImpl extends CartRepository {
  final CartDataSource dataSource;
  final NetworkInfo networkInfo;
  CartRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, CartResponseModel>> getCart() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getCart();
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> deleteItemFromCart(
      DeleteItemEntity entity) async {
    try {
      await ShoppingCartHelper.removeFromCart(entity.itemId);
      return Right(NoParams());
    } catch (e) {
      return const Left(ApiFailure(message: "Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, CouponResponseModel>> getCoupon(
      CouponEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getCouponDiscount(entity);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, AddressResponseModel>> saveAddress(
      Address entity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.saveAddress(entity);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Address>>> getAllAddresses(
      NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getAllAddresses();
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, OrderResponseModel>> placeOrder(
      OrderEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.placeOrder(entity);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
