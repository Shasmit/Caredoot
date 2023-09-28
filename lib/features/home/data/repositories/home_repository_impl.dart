import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/features/home/data/models/addtocart_model.dart';

import 'package:caredoot/features/home/data/models/categories_response_model.dart';
import 'package:caredoot/features/home/data/models/service_response_model.dart';
import 'package:caredoot/features/home/domain/entities/addtocart_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/subcategory_entity.dart';
import '../../domain/entities/subservice_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_data_source.dart';
import '../models/sub_services_response_model.dart';
import '../models/subcategory_response_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl(
    this.dataSource,
    this.networkInfo,
  );
  @override
  Future<Either<Failure, CategoriesResponseModel>> getAllCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getAllCategories();
        return Right(response as CategoriesResponseModel);
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
  Future<Either<Failure, SubCategoryResponseModel>> getAllSubCategories(
      SubCategoryEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final subCategoryResponse =
            await dataSource.getAllSubCategories(entity);
        return Right(subCategoryResponse);
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
  Future<Either<Failure, SubServiceResponseModel>> getAllSubServices(
      SubServiceEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final subServiceResponse = await dataSource.getAllSubServices(entity);
        return Right(subServiceResponse);
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
  Future<Either<Failure, ServiceResponseModel>> getAllServices() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getAllServices();
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
  Future<Either<Failure, AddToCartModel>> addToCart(
      AddToCartEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.addToCart(entity);
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
