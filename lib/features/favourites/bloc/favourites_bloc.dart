import 'package:bloc/bloc.dart';
import 'package:favourites_api/favourites_api.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc({required this.favouritesRepository})
      : super(FavouritesLoading()) {
    on<FavouritesStarted>(_onStarted);
    on<FavouritesAdded>(_onBreedAdded);
    on<FavouritesRemoved>(_onBreedRemoved);
  }
  final FavouritesApi favouritesRepository;

  Future<void> _onStarted(
    FavouritesStarted event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(FavouritesLoading());

    try {
      final favouriteItems = await favouritesRepository.loadFavourites();
      emit(
        FavouritesLoaded(
          favouritesList: FavouritesList(favourites: [...favouriteItems]),
        ),
      );
    } catch (_) {
      emit(FavouritesLoadingError());
    }
  }

  Future<void> _onBreedAdded(
    FavouritesAdded event,
    Emitter<FavouritesState> emit,
  ) async {
    final state = this.state;

    if (state is FavouritesLoaded) {
      try {
        await favouritesRepository.addBreedToFavourites(event.breed);

        emit(
          FavouritesLoaded(
            favouritesList: FavouritesList(
              favourites: [...state.favouritesList.favourites, event.breed],
            ),
          ),
        );
      } catch (_) {
        emit(FavouritesLoadingError());
      }
    }
  }

  Future<void> _onBreedRemoved(
    FavouritesRemoved event,
    Emitter<FavouritesState> emit,
  ) async {
    final state = this.state;

    if (state is FavouritesLoaded) {
      try {
        await favouritesRepository.removeBreedFromFavourites(event.breed);

        emit(
          FavouritesLoaded(
            favouritesList: FavouritesList(
              favourites: [...state.favouritesList.favourites]
                ..remove(event.breed),
            ),
          ),
        );
      } catch (_) {
        emit(FavouritesLoadingError());
      }
    }
  }
}
