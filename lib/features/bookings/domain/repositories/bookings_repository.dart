import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/features/bookings/data/models/bookings_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class BookingsRepository {
  Future<Either<Failure, List<OrderModel>>> getBookings(NoParams params);
}
