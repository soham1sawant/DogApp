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