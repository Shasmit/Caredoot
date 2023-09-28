import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/address_response_model.dart';

class AddAddressUseCase extends UseCase<AddressResponseModel, Address> {
  final CartRepository repository;
  AddAddressUseCase({required this.repository});
  @override
  Future<Either<Failure, AddressResponseModel>> call(Address params) {
    return repository.saveAddress(params);
  }
}
