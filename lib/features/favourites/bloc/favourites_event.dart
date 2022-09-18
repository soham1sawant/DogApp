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
  final BreedsModel breed;

  const FavouritesAdded(this.breed);

  @override
  List<Object> get props => [breed];
}

class FavouritesRemoved extends FavouritesEvent {
  final BreedsModel breed;

  const FavouritesRemoved(this.breed);

  @override
  List<Object> get props => [breed];
}
