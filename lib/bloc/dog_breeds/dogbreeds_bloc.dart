import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:dog_app/data/models/breeds_catalog.dart';
import 'package:dog_app/data/repositories/dog_repository.dart';

part 'dogbreeds_event.dart';
part 'dogbreeds_state.dart';

class DogBreedsBloc extends Bloc<DogBreedsEvent, DogBreedsState> {
  final DogRepository dogDataRepository;

  DogBreedsBloc({@required this.dogDataRepository}) : super(DogBreedsLoadInProgress()) {
    on<DogBreedsEvent>((event, emit) async {
      if (event is DogBreedsRequest) {
        emit(DogBreedsLoadInProgress());

        try {
          final dogDataResponse = await dogDataRepository.getDogData();
          emit(DogBreedsLoadSuccess(BreedsCatalog(dogDataResponse)));
        } catch (_) {
          emit(DogBreedsLoadFailure());
        }
      }
    });
  }
}
