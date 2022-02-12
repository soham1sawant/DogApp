import 'package:dog_app/data/models/breeds/breeds_model.dart';
import 'package:equatable/equatable.dart';

class FavouritesList extends Equatable {
  final List<BreedsModel> favourites;

  const FavouritesList({this.favourites = const <BreedsModel>[]});

  @override
  List<Object> get props => [favourites];
}
