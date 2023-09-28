import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/send_otp_entity.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../repositories/onboarding_repository.dart';

class SendOtpUseCase implements UseCase<NoParams, SendOtpEntity> {
  OnboardingRepository repository;
  SendOtpUseCase({required this.repository});
  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return repository.sendOtp(params);
  }
}
