import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favouritebutton_state.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState> {
  FavouriteButtonCubit() : super(FavouriteButtonDepressed());

  void addToFavourites() {
    emit(FavouriteButtonPressed());
  }

  void removeFromFavourites() {
    emit(FavouriteButtonDepressed());
  }
}
