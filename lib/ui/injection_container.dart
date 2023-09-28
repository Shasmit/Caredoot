import 'package:caredoot/features/cart/data/datasources/carts_data_source.dart';
import 'package:caredoot/features/cart/data/repositories/carts_repository_impl.dart';
import 'package:caredoot/features/cart/domain/repositories/cart_repository.dart';
import 'package:caredoot/features/cart/domain/usecases/add_address_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/coupon_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/create_order_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/deleteItem_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/get_addresses_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:caredoot/features/cart/presentation/bloc/bloc/cart_bloc.dart';
import 'package:caredoot/features/home/domain/repositories/home_repository.dart';
import 'package:caredoot/features/home/domain/usecases/addtocart_usecase.dart';

import 'package:caredoot/features/home/domain/usecases/get_Categories_UseCase.dart';
import 'package:caredoot/features/home/domain/usecases/service_usecase.dart';
import 'package:caredoot/features/home/domain/usecases/subcategory_usecase.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../core/network/network_info.dart';
import '../features/dashboard/presentation/bloc/dashboard_bloc.dart';

import '../features/home/data/datasources/home_data_source.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/usecases/subservice_usecase.dart';

import '../features/onboarding/data/datasources/onboarding_data_source.dart';
import '../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../features/onboarding/domain/usecases/send_otp_usecase.dart';

import '../features/home/presentation/bloc/home/home_bloc.dart';
import '../features/home/presentation/bloc/service/service_bloc.dart';
import '../features/home/presentation/bloc/subservices/subservice_bloc.dart';
import '../features/onboarding/domain/usecases/verify_otp_usecase.dart';
import '../features/onboarding/presentation/bloc/onboarding_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  general();
  injectHome();
  injectDashboard();
  injectAuth();
  injectCart();
}

void general() {
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

void injectDashboard() {
  sl.registerFactory<DashboardBloc>(() => DashboardBloc());
}

//========INJECT HOME ===========================

void injectHome() {
  sl.registerFactory<HomeBloc>(
      () => HomeBloc(categoryUsecase: sl(), serviceUsecase: sl()));
  sl.registerFactory<ServiceBloc>(() => ServiceBloc(subCategoryUseCase: sl()));
  sl.registerFactory<SubServiceBloc>(() => SubServiceBloc(
      subServiceUseCase: sl(), getCartUseCase: sl(), addToCartUseCase: sl()));

  /// Use cases
  sl.registerLazySingleton(() => CategoryUsecase(repository: sl()));
  sl.registerLazySingleton(() => ServiceUsecase(serviceRepository: sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => SubCategoryUseCase(subCategoryRepository: sl()));
  sl.registerLazySingleton(() => SubServiceUseCase(subServiceRepository: sl()));

  /// Repositories
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl(), sl()));

  /// Data sources
  sl.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());
}

//=======================INJECT AUTH =====================================
void injectAuth() {
  sl.registerFactory<OnboardingBloc>(
      () => OnboardingBloc(sendOtpUseCase: sl(), verifyOtpUseCase: sl()));

  /// Use cases

  sl.registerLazySingleton(() => SendOtpUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(repository: sl()));

  /// Repositories
  sl.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(dataSource: sl(), networkInfo: sl()));

  /// Data sources

  sl.registerLazySingleton<OnboardingDataSource>(
      () => OnboardingsDataSourceImpl());
}

void injectCart() {
  sl.registerLazySingleton(() => GetCartUseCase(cartRepository: sl()));
  sl.registerLazySingleton(() => GetAddressesUseCase(repository: sl()));
  sl.registerLazySingleton(() => CouponUseCase(cartRepository: sl()));
  sl.registerLazySingleton(() => DeleteItemFromCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddAddressUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateOrderUsecase(cartRepository: sl()));

  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(dataSource: sl(), networkInfo: sl()));
  sl.registerFactory<CartBloc>(() => CartBloc(
      getCartUseCase: sl(),
      deleteItemFromCartUseCase: sl(),
      getAddressUsecase: sl(),
      couponUseCase: sl(),
      createOrderUsecase: sl(),
      addAddressUseCase: sl()));
  sl.registerLazySingleton<CartDataSource>(() => CartDataSourceImpl());
}
