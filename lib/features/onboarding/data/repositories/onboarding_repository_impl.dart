import 'package:caredoot/features/onboarding/domain/entities/verify_otp_entity.dart';

import 'package:dartz/dartz.dart';
import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';

import '../../domain/entities/send_otp_entity.dart';
import '../../domain/repositories/onboarding_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/onboarding_data_source.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final OnboardingDataSource dataSource;
  final NetworkInfo networkInfo;
  OnboardingRepositoryImpl(
      {required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, NoParams>> sendOtp(SendOtpEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final userResponse = await dataSource.sendOtp(entity);
        return Right(userResponse);
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
  Future<Either<Failure, NoParams>> verifyOtp(VerifyOtpEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final userResponse = await dataSource.verifyOtp(entity);
        return Right(userResponse);
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
