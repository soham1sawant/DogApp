part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}

class FavouritesStarted extends FavouritesEvent {
  @override
  List<Object> get props => [];
}

class FavouritesAdded extends FavouritesEvent {

  const FavouritesAdded(this.breed);
  final BreedsModel breed;

  @override
  List<Object> get props => [breed];
}

class FavouritesRemoved extends FavouritesEvent {

  const FavouritesRemoved(this.breed);
  final BreedsModel breed;

  @override
  List<Object> get props => [breed];
}
