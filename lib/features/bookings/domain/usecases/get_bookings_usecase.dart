import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/features/bookings/data/models/bookings_model.dart';
import 'package:caredoot/features/bookings/domain/repositories/bookings_repository.dart';
import 'package:dartz/dartz.dart';

class GetBookingsUseCase extends UseCase<List<OrderModel>, NoParams> {
  BookingsRepository repository;
  GetBookingsUseCase({required this.repository});
  @override
  Future<Either<Failure, List<OrderModel>>> call(NoParams params) {
    return repository.getBookings(params);
  }
}
