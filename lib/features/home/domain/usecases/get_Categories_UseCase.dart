import 'package:caredoot/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/categories_response_model.dart';

class CategoryUsecase extends UseCase<CategoriesResponseModel, NoParams> {
  final HomeRepository repository;
  CategoryUsecase({required this.repository});
  @override
  Future<Either<Failure, CategoriesResponseModel>> call(NoParams params) {
    return repository.getAllCategories();
  }
}
