import 'package:caredoot/features/cart/data/models/order_response_model.dart';
import 'package:caredoot/features/cart/domain/entities/order_entity.dart';
import 'package:caredoot/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';

class CreateOrderUsecase implements UseCase<OrderResponseModel, OrderEntity> {
  final CartRepository cartRepository;

  const CreateOrderUsecase({
    required this.cartRepository,
  });

  @override
  Future<Either<Failure, OrderResponseModel>> call(OrderEntity entity) {
    return cartRepository.placeOrder(entity);
  }
}
