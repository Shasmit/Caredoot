import 'package:caredoot/features/home/data/models/addtocart_model.dart';
import 'package:caredoot/features/home/domain/entities/addtocart_entity.dart';
import 'package:caredoot/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';

class AddToCartUseCase implements UseCase<AddToCartModel, AddToCartEntity> {
  final HomeRepository repository;

  const AddToCartUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, AddToCartModel>> call(AddToCartEntity entity) {
    return repository.addToCart(entity);
  }
}
