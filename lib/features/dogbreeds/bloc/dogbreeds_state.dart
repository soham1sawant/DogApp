part of 'dogbreeds_bloc.dart';

@immutable
abstract class DogBreedsState extends Equatable {}

class DogBreedsLoadInProgress extends DogBreedsState {
  @override
  List<Object> get props => [];
}

class DogBreedsLoadSuccess extends DogBreedsState {
  DogBreedsLoadSuccess(this.breedsCatalog);
  final BreedsCatalog breedsCatalog;

  @override
  List<Object> get props => [breedsCatalog];
}

class DogBreedsLoadFailure extends DogBreedsState {
  @override
  List<Object> get props => [];
}

class DogBreedImageUrlLoadInProgress extends DogBreedsState {
  @override
  List<Object> get props => [];
}

class DogBreedImageUrlLoadSuccess extends DogBreedsState {
  final ImagePath image;

  DogBreedImageUrlLoadSuccess(this.image);

  @override
  List<Object> get props => [];
}

class DogBreedImageUrlFailure extends DogBreedsState {
  @override
  List<Object> get props => [];
}
