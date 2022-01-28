import 'package:bloc/bloc.dart';
import 'package:dog_app/data/models/favourites_list.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:dog_app/data/repositories/dog_repository.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final DogRepository dogDataRepository;

  FavouritesBloc({@required this.dogDataRepository}) : super(FavouritesLoading()) {
    on<FavouritesStarted>(_onStarted);
    on<FavouritesAdded>(_onBreedAdded);
    on<FavouritesRemoved>(_onBreedRemoved);
  }

  void _onStarted(
      FavouritesStarted event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoading());

    try {
      final favouriteItems = await dogDataRepository.loadFavourites();
      emit(FavouritesLoaded(
          favouritesList: FavouritesList(favourites: [...favouriteItems])));
    } catch (_) {
      emit(FavouritesLoadingError());
    }
  }

  void _onBreedAdded(FavouritesAdded event, Emitter<FavouritesState> emit) {
    final state = this.state;

    if (state is FavouritesLoaded) {
      try {
        dogDataRepository.addBreedToFavourites(event.breed);
        emit(FavouritesLoaded(
            favouritesList: FavouritesList(favourites: [
          ...state.favouritesList.favourites,
          event.breed
        ])));
      } catch (_) {
        FavouritesLoadingError();
      }
    }
  }

  void _onBreedRemoved(FavouritesRemoved event, Emitter<FavouritesState> emit) {
    final state = this.state;

    if (state is FavouritesLoaded) {
      try {
        dogDataRepository.removeBreedFromFavourites(event.breed);
        emit(FavouritesLoaded(
            favouritesList: FavouritesList(
                favourites: [...state.favouritesList.favourites]
                  ..remove(event.breed))));
      } catch (_) {
        FavouritesLoadingError();
      }
    }
  }
}
