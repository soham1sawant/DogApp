import 'package:bloc/bloc.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:meta/meta.dart';

part 'favouritebreeds_event.dart';
part 'favouritebreeds_state.dart';

class FavouriteBreedsBloc
    extends Bloc<FavouriteBreedsEvent, FavouriteBreedsState> {
  FavouriteBreedsBloc() : super(FavouriteBreedsLoading()) {
    on<FavouriteBreedsEvent>((event, emit) {
      if (event is FavouriteBreedsEventRequest) {
        emit(FavouriteBreedsLoading());

        if (state.favouriteBreeds.isEmpty) {
          emit(FavouriteBreedsEmpty());
        } else if (state.favouriteBreeds.isNotEmpty) {
          emit(FavouriteBreedsLoadSuccess());
        } else {
          emit(FavouriteBreedsLoadFailure());
        }
      }
    });
  }
}
