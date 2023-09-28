import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/error/exception.dart';
import 'package:caredoot/core/error/failure.dart';
import 'package:caredoot/core/network/network_info.dart';
import 'package:caredoot/features/bookings/data/datasources/bookings_data_source.dart';
import 'package:caredoot/features/bookings/data/models/bookings_model.dart';
import 'package:caredoot/features/bookings/domain/repositories/bookings_repository.dart';
import 'package:dartz/dartz.dart';

class BookingsRepositoryImpl extends BookingsRepository {
  BookingsDataSource dataSource;
  NetworkInfo networkInfo;
  BookingsRepositoryImpl({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<OrderModel>>> getBookings(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getBookings(params);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
