import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/features/cart/data/models/cart_response_model.dart';
import 'package:caredoot/features/cart/domain/repositories/cart_repository.dart';
import 'package:caredoot/features/cart/presentation/pages/cart_page.dart';
import 'package:dartz/dartz.dart';

class GetCartUseCase extends UseCase<CartResponseModel, NoParams> {
  final CartRepository cartRepository;
  GetCartUseCase({required this.cartRepository});
  @override
  Future<Either<Failure, CartResponseModel>> call(NoParams params) {
    return cartRepository.getCart();
  }
}
