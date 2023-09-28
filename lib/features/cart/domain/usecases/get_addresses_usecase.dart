import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class GetAddressesUseCase extends UseCase<List<Address>, NoParams> {
  final CartRepository repository;
  GetAddressesUseCase({required this.repository});
  @override
  Future<Either<Failure, List<Address>>> call(NoParams params) {
    return repository.getAllAddresses(params);
  }
}
