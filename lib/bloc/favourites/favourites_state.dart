part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesState extends Equatable {}

class FavouritesLoading extends FavouritesState {
  @override
  List<Object> get props => [];
}

class FavouritesLoaded extends FavouritesState {
  final FavouritesList favouritesList;

  FavouritesLoaded({this.favouritesList = const FavouritesList()});

  @override
  List<Object> get props => [favouritesList];
}

class FavouritesLoadingError extends FavouritesState {
  @override
  List<Object> get props => [];
}
