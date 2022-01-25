part of 'dogbreeds_bloc.dart';

@immutable
class DogBreedsState {}

class DogBreedsLoadInProgress extends DogBreedsState {}

class DogBreedsLoadSuccess extends DogBreedsState {
  final List<BreedsModel> breeds;

  DogBreedsLoadSuccess(this.breeds);
}

class DogBreedsLoadFailure extends DogBreedsState {}
