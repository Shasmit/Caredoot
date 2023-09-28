import 'package:caredoot/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/sub_services_response_model.dart';

import '../entities/subservice_entity.dart';

class SubServiceUseCase
    implements UseCase<SubServiceResponseModel, SubServiceEntity> {
  final HomeRepository subServiceRepository;

  const SubServiceUseCase({
    required this.subServiceRepository,
  });

  @override
  Future<Either<Failure, SubServiceResponseModel>> call(
      SubServiceEntity entity) {
    return subServiceRepository.getAllSubServices(entity);
  }
}
