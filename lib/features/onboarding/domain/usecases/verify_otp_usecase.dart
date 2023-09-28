import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../entities/verify_otp_entity.dart';
import '../repositories/onboarding_repository.dart';

class VerifyOtpUseCase implements UseCase<NoParams, VerifyOtpEntity> {
  OnboardingRepository repository;
  VerifyOtpUseCase({required this.repository});
  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return repository.verifyOtp(params);
  }
}
