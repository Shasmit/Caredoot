import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/delete_entity.dart';

class DeleteItemFromCartUseCase extends UseCase<NoParams, DeleteItemEntity> {
  final CartRepository repository;
  DeleteItemFromCartUseCase({required this.repository});
  @override
  Future<Either<Failure, NoParams>> call(params) {
    return repository.deleteItemFromCart(params);
  }
}
