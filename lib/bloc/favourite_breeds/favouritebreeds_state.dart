part of 'favouritebreeds_bloc.dart';

@immutable
class FavouriteBreedsState {}

class FavouritebreedsInitial extends FavouriteBreedsState {
  final List<BreedsModel> favouriteBreeds = [];

  void addBreed(BreedsModel breed) {
    favouriteBreeds.add(breed);
  }

  void removeBreed(BreedsModel breed) {
    favouriteBreeds.remove(breed);
  }
}
