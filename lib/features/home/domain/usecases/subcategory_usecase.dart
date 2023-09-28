import 'package:caredoot/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/subcategory_response_model.dart';
import '../entities/subcategory_entity.dart';

class SubCategoryUseCase
    implements UseCase<SubCategoryResponseModel, SubCategoryEntity> {
  final HomeRepository subCategoryRepository;

  const SubCategoryUseCase({
    required this.subCategoryRepository,
  });

  @override
  Future<Either<Failure, SubCategoryResponseModel>> call(
      SubCategoryEntity entity) {
    return subCategoryRepository.getAllSubCategories(entity);
  }
}
