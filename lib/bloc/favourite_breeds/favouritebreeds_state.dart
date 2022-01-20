part of 'favouritebreeds_bloc.dart';

@immutable
class FavouriteBreedsState {
  final List<BreedsModel> favouriteBreeds = [];
}

class FavouriteBreedsLoading extends FavouriteBreedsState {}

class FavouriteBreedsLoadSuccess extends FavouriteBreedsState {}

class FavouriteBreedsEmpty extends FavouriteBreedsState {}

class FavouriteBreedsLoadFailure extends FavouriteBreedsState {}