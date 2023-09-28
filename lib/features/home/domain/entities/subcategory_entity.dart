import 'package:equatable/equatable.dart';

class SubCategoryEntity extends Equatable {
  final String slug;

  const SubCategoryEntity(this.slug);

  @override
  // TODO: implement props
  List<String> get props => [slug];
}
