part of 'favourites_cubit.dart';

@immutable
abstract class FavouritesState {
  final List<BreedsModel> favouriteBreeds = [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesAdded extends FavouritesState {}

class FavouritesRemoved extends FavouritesState {}
