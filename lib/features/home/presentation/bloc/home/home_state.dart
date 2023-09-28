import 'package:caredoot/features/home/data/models/service_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/categories_response_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends HomeState {}

//======================Category State===========================

class CategoryLoadingState extends HomeState {}

class CategoryLoadedFailureState extends HomeState {
  final String message;

  const CategoryLoadedFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryLoadedSuccessfullState extends HomeState {
  final CategoriesResponseModel CategoryPosts;

  @override
  List<Object> get props => [CategoryPosts];

  const CategoryLoadedSuccessfullState(this.CategoryPosts);
}

//======================Service State=========================================

class ServiceLoadingState extends HomeState {}

class ServiceLoadedFailureState extends HomeState {
  final String message;

  const ServiceLoadedFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class ServiceLoadedSuccessfullState extends HomeState {
  final ServiceResponseModel serviceResponseModel;

  @override
  List<Object> get props => [serviceResponseModel];

  const ServiceLoadedSuccessfullState(this.serviceResponseModel);
}
