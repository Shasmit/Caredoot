import 'package:caredoot/features/home/domain/entities/addtocart_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/subservice_entity.dart';

abstract class SubServiceEvent extends Equatable {
  const SubServiceEvent();

  @override
  List<Object> get props => [];
}

class GetSubServiceEvent extends SubServiceEvent {
  final SubServiceEntity entity;

  const GetSubServiceEvent(this.entity);
}

class GetCartEvent extends SubServiceEvent {}

class AddToCartEvent extends SubServiceEvent {
  final AddToCartEntity entity;
  const AddToCartEvent({required this.entity});
  @override
  List<Object> get props => [entity];
}
