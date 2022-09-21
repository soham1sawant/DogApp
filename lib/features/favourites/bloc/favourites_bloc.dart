import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../dogbreeds/data/dog_repository.dart';
import '../../dogbreeds/models/breeds/breeds_model.dart';
import '../models/favourites_list.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends HydratedBloc<FavouritesEvent, FavouritesState> {
  final DogRepository repository;

  FavouritesBloc({required this.repository}) : super(FavouritesLoading()) {
    on<FavouritesStarted>(_onStarted);
    on<FavouritesAdded>(_onBreedAdded);
    on<FavouritesRemoved>(_onBreedRemoved);
  }

  void _onStarted(
      FavouritesStarted event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoading());

    try {
      final favouriteItems = await repository.loadFavourites();
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
        repository.addBreedToFavourites(event.breed);
        emit(FavouritesLoaded(
            favouritesList: FavouritesList(favourites: [
          ...state.favouritesList.favourites,
          event.breed
        ])));
      } catch (_) {
        emit(FavouritesLoadingError());
      }
    }
  }

  void _onBreedRemoved(FavouritesRemoved event, Emitter<FavouritesState> emit) {
    final state = this.state;

    if (state is FavouritesLoaded) {
      try {
        repository.removeBreedFromFavourites(event.breed);
        emit(FavouritesLoaded(
            favouritesList: FavouritesList(
                favourites: [...state.favouritesList.favourites]
                  ..remove(event.breed))));
      } catch (_) {
        emit(FavouritesLoadingError());
      }
    }
  }

  @override
  FavouritesState? fromJson(Map<String, dynamic> json) {
    try {
      final storedFavouriteBreeds = FavouritesLoaded.fromMap(json);
      repository.favouriteBreeds =
          storedFavouriteBreeds.favouritesList.favourites;

      return FavouritesLoaded(
          favouritesList: storedFavouriteBreeds.favouritesList);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(FavouritesState state) {
    if (state is FavouritesLoaded) {
      return state.toMap();
    } else {
      return null;
    }
  }
}
