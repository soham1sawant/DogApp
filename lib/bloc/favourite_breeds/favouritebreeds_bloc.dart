import 'package:bloc/bloc.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:meta/meta.dart';

part 'favouritebreeds_event.dart';
part 'favouritebreeds_state.dart';

class FavouriteBreedsBloc extends Bloc<FavouriteBreedsEvent, FavouriteBreedsState> {

  FavouriteBreedsBloc() : super(FavouritebreedsInitial()) {
    on<FavouriteBreedsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
