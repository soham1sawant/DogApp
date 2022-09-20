import 'package:equatable/equatable.dart';

import 'breeds/breeds_model.dart';

class BreedsCatalog extends Equatable {
  final List<BreedsModel> loadedBreeds;

  const BreedsCatalog(this.loadedBreeds);

  @override
  List<Object> get props => [loadedBreeds];
}
