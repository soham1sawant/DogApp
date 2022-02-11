part of 'dogbreeds_bloc.dart';

@immutable
class DogBreedsState extends Equatable {
  @override
  List<Object> get props => [];
}

class DogBreedsLoadInProgress extends DogBreedsState {
  @override
  List<Object> get props => [];
}

class DogBreedsLoadSuccess extends DogBreedsState {
  final BreedsCatalog breedsCatalog;

  DogBreedsLoadSuccess(this.breedsCatalog);

  @override
  List<Object> get props => [breedsCatalog];
}

class DogBreedsLoadFailure extends DogBreedsState {
  
  @override
  List<Object> get props => [];
}
