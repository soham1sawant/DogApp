part of 'dogbreeds_bloc.dart';

@immutable
abstract class DogBreedsEvent extends Equatable {}

class DogBreedsRequest extends DogBreedsEvent {
  @override
  List<Object> get props => [];
}

class DogBreedImageUrlRequest extends DogBreedsEvent {
  final String imageId;

  DogBreedImageUrlRequest({required this.imageId});

  @override
  List<Object?> get props => [imageId];
}
