import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:equatable/equatable.dart';


class BreedsCatalog extends Equatable {

  const BreedsCatalog(this.loadedBreeds);
  final List<BreedsModel> loadedBreeds;

  @override
  List<Object> get props => [loadedBreeds];
}
