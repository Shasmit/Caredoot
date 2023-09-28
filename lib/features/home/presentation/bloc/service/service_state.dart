import 'package:equatable/equatable.dart';

import '../../../data/models/subcategory_response_model.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class SubCategoryInitial extends ServiceState {}

class SubCategoryLoadingState extends ServiceState {
  const SubCategoryLoadingState();
}

class SubCategorySuccessState extends ServiceState {
  final SubCategoryResponseModel subCategoryResponseModel;
  @override
  List<Object> get props => [subCategoryResponseModel];
  const SubCategorySuccessState(this.subCategoryResponseModel);
}

class SubCategoryFailureState extends ServiceState {
  final String errorMessage;

  const SubCategoryFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
