import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:dog_app/data/models/breeds_catalog.dart';
import 'package:dog_app/data/repositories/repository.dart';

part 'dogbreeds_event.dart';
part 'dogbreeds_state.dart';

class DogBreedsBloc extends Bloc<DogBreedsEvent, DogBreedsState> {
  final Repository repository;

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
