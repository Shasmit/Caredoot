import 'dart:convert';

import 'package:caredoot/core/helpers/user_helpers.dart';
import 'package:caredoot/features/onboarding/data/models/user_details_model.dart';

import '../../../../core/apis/base/custom_http_client.dart';
import '../../../../core/constants/url_constants.dart';
import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/helpers/utils.dart';
import '../../domain/entities/send_otp_entity.dart';
import '../../domain/entities/verify_otp_entity.dart';

abstract class OnboardingDataSource {
  Future<NoParams> sendOtp(SendOtpEntity entity);
  Future<NoParams> verifyOtp(VerifyOtpEntity entity);
}

class OnboardingsDataSourceImpl extends OnboardingDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();

  @override
  Future<NoParams> sendOtp(SendOtpEntity entity) async {
    // print(entity.phoneNumber);
    print("==================INITIATE API====================");
    final response = await customHttpClient.post(
        Uri.parse(SEND_OTP), json.encode(entity.toMap()));
    Utils.printJson(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("hello============================");
      var result = json.decode(response.body)["msg"];
      print(result);
      return NoParams();
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NoParams> verifyOtp(VerifyOtpEntity entity) async {
    print("==================INITIATE API====================");
    final response = await customHttpClient.post(
      Uri.parse(VERIFY_OTP),
      jsonEncode(
        <String, dynamic>{
          'phone': entity.phone,
          'otp': entity.otp,
        },
      ),
    );
    Utils.printJson(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var result = json.decode(response.body)["msg"];
      print(result);
      var userDetails =
          UserDetails.fromMap(json.decode(response.body)["data"][0]);
      UserHelpers.setUserDetails(userDetails);
      return NoParams();
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }
}
