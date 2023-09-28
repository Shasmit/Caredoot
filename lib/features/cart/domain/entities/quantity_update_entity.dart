import 'package:equatable/equatable.dart';

class QtyUpdateEntity extends Equatable {
  String itemId;
  int qty;
  QtyUpdateEntity({
    required this.itemId,
    required this.qty,
  });

  @override
  List<Object?> get props => [itemId, qty];
}
