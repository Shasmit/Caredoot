import 'package:equatable/equatable.dart';

import '../../../domain/entities/subcategory_entity.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class GetSubCategoryEvent extends ServiceEvent {
  final SubCategoryEntity entity;

  const GetSubCategoryEvent(this.entity);
}
