import 'package:bloc/bloc.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:dog_app/data/repositories/dog_data_repository.dart';
import 'package:meta/meta.dart';

part 'dogbreeds_event.dart';
part 'dogbreeds_state.dart';

class DogBreedsBloc extends Bloc<DogBreedsEvent, DogBreedsState> {
  final DogDataRepository _dogDataRepository = DogDataRepository();

  DogBreedsBloc() : super(DogBreedsLoadInProgress()) {
    on<DogBreedsEvent>((event, emit) async {
      if (event is DogBreedsRequest) {
        emit(DogBreedsLoadInProgress());

        try {
          final dogDataResponse = await _dogDataRepository.getDogData();
          emit(DogBreedsLoadSuccess(dogDataResponse));
        } catch (_) {
          emit(DogBreedsLoadFailure());
        }
      }
    });
  }
}
