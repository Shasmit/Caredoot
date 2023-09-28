import 'dart:convert';

import 'package:caredoot/core/apis/base/custom_http_client.dart';
import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/exception.dart';
import 'package:caredoot/core/helpers/user_helpers.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/bookings/data/models/bookings_model.dart';

abstract class BookingsDataSource {
  Future<List<OrderModel>> getBookings(NoParams params);
}

class BookingsDataSourceImpl implements BookingsDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();

  @override
  Future<List<OrderModel>> getBookings(NoParams params) async {
    var userKey = UserHelpers.userDetails?.userKey;
    List<OrderModel> orders = [];
    print("=====================Add To Cart ===============");
    final response =
        await customHttpClient.get(Uri.parse("$OrderUrl/$userKey"));
    Utils.printJson(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var result = json.decode(response.body);
      for (var order in result["data"]) {
        orders.add(OrderModel.fromJson(order));
      }
      return orders;
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }
}
