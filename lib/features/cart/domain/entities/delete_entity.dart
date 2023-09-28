import 'package:equatable/equatable.dart';

class DeleteItemEntity extends Equatable {
  final String itemId;
  const DeleteItemEntity({required this.itemId});

  @override
  List<Object?> get props => [itemId];
}
