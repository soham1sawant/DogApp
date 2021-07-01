import 'package:bloc/bloc.dart';
import 'package:dog_app/presentation/pages/favourites_page.dart';
import 'package:equatable/equatable.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteEmpty());

  void addToFavourite(breed) => emit(FavouriteAdded(breed));

  void removeFromFavourite(breed) => emit(FavouriteRemoved(breed));
}
