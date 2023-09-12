import 'package:bloc/bloc.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'dogbreeds_event.dart';
part 'dogbreeds_state.dart';

class DogBreedsBloc extends Bloc<DogBreedsEvent, DogBreedsState> {
  DogBreedsBloc(this.dogbreedsApiClient) : super(DogBreedsLoadInProgress()) {
    on<DogBreedsEvent>((event, emit) async {
      if (event is DogBreedsRequest) {
        emit(DogBreedsLoadInProgress());

        try {
          final breeds = await dogbreedsApiClient.dogData();
          emit(DogBreedsLoadSuccess(BreedsCatalog(breeds)));
        } catch (e) {
          emit(DogBreedsLoadFailure());
        }
      } else if (event is DogBreedImageUrlRequest) {
        emit(DogBreedImageUrlLoadInProgress());

        try {
          final breedUrl = await dogbreedsApiClient.getImageUrl(event.imageId);
          emit(DogBreedImageUrlLoadSuccess(breedUrl));
        } catch (e) {
          emit(DogBreedImageUrlFailure());
        }
      }
    });
  }
  final DogbreedsApiClient dogbreedsApiClient;
}
