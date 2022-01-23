import 'package:bloc/bloc.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:meta/meta.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());

  void addToFavourites(BreedsModel breed) {
    if (state.favouriteBreeds.contains(breed) == false) {
      state.favouriteBreeds.add(breed);
    }
    emit(FavouritesAdded());
  }

  void removeFromFavourites(BreedsModel breed) {
    if (state.favouriteBreeds.contains(breed)) {
      state.favouriteBreeds.remove(breed);
    }
    emit(FavouritesRemoved());
  }

  get getfavouriteBreeds {
    return state.favouriteBreeds;
  }
}
