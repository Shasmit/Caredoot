import 'package:dartz/dartz.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';
import '../entities/send_otp_entity.dart';
import '../entities/verify_otp_entity.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, NoParams>> sendOtp(SendOtpEntity entity);
  Future<Either<Failure, NoParams>> verifyOtp(VerifyOtpEntity entity);
}
