import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/features/cart/domain/entities/delete_entity.dart';
import 'package:caredoot/features/home/data/models/addtocart_model.dart';
import 'package:caredoot/features/home/data/models/service_response_model.dart';
import 'package:caredoot/features/home/domain/entities/addtocart_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/categories_response_model.dart';
import '../../data/models/sub_services_response_model.dart';
import '../../data/models/subcategory_response_model.dart';
import '../entities/subcategory_entity.dart';
import '../entities/subservice_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, CategoriesResponseModel>> getAllCategories();
  Future<Either<Failure, ServiceResponseModel>> getAllServices();
  Future<Either<Failure, SubCategoryResponseModel>> getAllSubCategories(
      SubCategoryEntity entity);
  Future<Either<Failure, SubServiceResponseModel>> getAllSubServices(
      SubServiceEntity entity);

  Future<Either<Failure, AddToCartModel>> addToCart(AddToCartEntity entity);
}
