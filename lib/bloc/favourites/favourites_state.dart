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

 Map<String, dynamic> toMap() {
    return {
      'favouritesList': favouritesList.toMap(),
    };
  }

  factory FavouritesLoaded.fromMap(Map<String, dynamic> map) {
    return FavouritesLoaded(
      favouritesList: FavouritesList.fromMap(map['favouritesList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouritesLoaded.fromJson(String source) => FavouritesLoaded.fromMap(json.decode(source));

  @override
  List<Object> get props => [favouritesList];
}

class FavouritesLoadingError extends FavouritesState {
  @override
  List<Object> get props => [];
}
