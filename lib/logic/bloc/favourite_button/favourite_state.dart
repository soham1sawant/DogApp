part of 'favourite_cubit.dart';

abstract class FavouriteState extends Equatable {
  

  @override
  List<Object> get props => [];
}

class FavouriteEmpty extends FavouriteState {}

class FavouriteAdded extends FavouriteState {
  final breed;

  FavouriteAdded(this.breed) {
    if(FavouritesPage.likedList.contains(breed) == false) {
    FavouritesPage.likedList.add(breed);
    print(FavouritesPage.likedList);
    }
  }

  @override
  List<Object> get props => [breed];
}

class FavouriteRemoved extends FavouriteState {
  final breed;

  FavouriteRemoved(this.breed) {
    if (FavouritesPage.likedList.isNotEmpty && FavouritesPage.likedList.contains(breed)) {
      FavouritesPage.likedList.remove(breed);
      print(FavouritesPage.likedList);
    }
  }
}
