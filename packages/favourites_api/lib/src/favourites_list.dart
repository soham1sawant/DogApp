import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:equatable/equatable.dart';

class FavouritesList extends Equatable {

  const FavouritesList({this.favourites = const <BreedsModel>[] });
  final List<BreedsModel> favourites;

  @override
  List<Object?> get props => [favourites];
}
