import 'package:caredoot/features/home/data/models/service_response_model.dart';
import 'package:caredoot/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';

class ServiceUsecase extends UseCase<ServiceResponseModel, NoParams> {
  final HomeRepository serviceRepository;
  ServiceUsecase({required this.serviceRepository});
  @override
  Future<Either<Failure, ServiceResponseModel>> call(NoParams params) {
    return serviceRepository.getAllServices();
  }
}
