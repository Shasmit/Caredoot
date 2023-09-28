import 'package:equatable/equatable.dart';

class SubServiceEntity extends Equatable {
  final String slug;

  const SubServiceEntity(this.slug);

  @override
  // TODO: implement props
  List<String> get props => [slug];
}
