import 'dart:convert';
import 'package:caredoot/core/apis/base/custom_http_client.dart';
import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/features/home/data/models/addtocart_model.dart';
import 'package:caredoot/features/home/data/models/categories_response_model.dart';
import 'package:caredoot/features/home/data/models/service_response_model.dart';
import 'package:caredoot/features/home/domain/entities/addtocart_entity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/helpers/utils.dart';
import '../../domain/entities/subcategory_entity.dart';
import '../../domain/entities/subservice_entity.dart';
import '../models/sub_services_response_model.dart';
import '../models/subcategory_response_model.dart';

abstract class HomeDataSource {
  Future<CategoriesResponseModel> getAllCategories();
  Future<ServiceResponseModel> getAllServices();
  Future<AddToCartModel> addToCart(AddToCartEntity entity);

  Future<SubCategoryResponseModel> getAllSubCategories(
      SubCategoryEntity entity);

  Future<SubServiceResponseModel> getAllSubServices(SubServiceEntity entity);
}

class HomeDataSourceImpl extends HomeDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();

  @override
  Future<CategoriesResponseModel> getAllCategories() async {
    print(
        '============================get all categories========================');
    final response = await customHttpClient.get(
      Uri.parse(
        GET_CATEGORY_LIST,
      ),
    );
    Utils.printJson(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var result = json.decode(response.body);
      return CategoriesResponseModel.fromMap(result);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SubCategoryResponseModel> getAllSubCategories(
      SubCategoryEntity entity) async {
    print("=====================SubCategory Init ===============");
    print(entity.slug);
    final response = entity.slug != 'all'
        ? await customHttpClient.get(
            Uri.parse(
              '$GET_SUBCATEGORY_LIST/${entity.slug}',
            ),
          )
        : await customHttpClient.get(
            Uri.parse(
              GET_SERVICE_LIST,
            ),
          );
    Utils.printJson(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var result = json.decode(response.body);
      return SubCategoryResponseModel.fromMap(result);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SubServiceResponseModel> getAllSubServices(
      SubServiceEntity entity) async {
    print("=====================SubCategory Init ===============");
    final response = await customHttpClient.get(
      Uri.parse(
        '$GET_SUBSERVICE_LIST/${entity.slug}',
      ),
    );
    Utils.printJson(response.body);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      return SubServiceResponseModel.fromMap(result);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ServiceResponseModel> getAllServices() async {
    print('============================Get Services===================');
    final response = await customHttpClient.get(
      Uri.parse(
        GET_SERVICE_LIST,
      ),
    );
    Utils.printJson(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var result = json.decode(response.body);
      return ServiceResponseModel.fromMap(result);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddToCartModel> addToCart(AddToCartEntity entity) async {
    print("=====================Add To Cart ===============");
    final response =
        await customHttpClient.post(Uri.parse(ADD_TO_CART), entity.toJson());
    Utils.printJson(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var result = json.decode(response.body);
      return AddToCartModel.fromMap(result);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }
}
