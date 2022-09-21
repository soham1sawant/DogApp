import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../data/dog_repository.dart';
import '../models/breeds_catalog.dart';

part 'dogbreeds_event.dart';
part 'dogbreeds_state.dart';

class DogBreedsBloc extends Bloc<DogBreedsEvent, DogBreedsState> {
  final DogRepository repository;

  DogBreedsBloc({required this.repository}) : super(DogBreedsLoadInProgress()) {
    on<DogBreedsEvent>((event, emit) async {
      if (event is DogBreedsRequest) {
        emit(DogBreedsLoadInProgress());

        try {
          final dogDataResponse = await repository.getDogData();
          emit(DogBreedsLoadSuccess(BreedsCatalog(dogDataResponse)));
        } catch (_) {
          emit(DogBreedsLoadFailure());
        }
      }
    });
  }
}
