import 'package:caredoot/features/cart/data/models/coupon_response_model.dart';
import 'package:caredoot/features/cart/domain/entities/coupon_entity.dart';
import 'package:caredoot/features/cart/domain/repositories/cart_repository.dart';
import 'package:caredoot/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';


class CouponUseCase
    implements UseCase<CouponResponseModel, CouponEntity> {
  final CartRepository cartRepository;

  const CouponUseCase({
    required this.cartRepository,
  });

  @override
  Future<Either<Failure, CouponResponseModel>> call(
      CouponEntity entity) {
    return cartRepository.getCoupon(entity);
  }
}
