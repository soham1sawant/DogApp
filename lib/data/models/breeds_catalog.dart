import 'package:dog_app/data/models/breeds/breeds_model.dart';
import 'package:equatable/equatable.dart';

class BreedsCatalog extends Equatable {
  final List<BreedsModel> loadedBreeds;

  const BreedsCatalog(this.loadedBreeds);

  @override
  List<Object> get props => [loadedBreeds];
}
