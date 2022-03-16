import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:dog_app/data/models/breeds/breeds_model.dart';

class FavouritesList extends Equatable {
  final List<BreedsModel> favourites;

  const FavouritesList({this.favourites = const <BreedsModel>[]});

 Map<String, dynamic> toMap() {
    return {
      'favourites': favourites.map((x) => x.toJson()).toList(),
    };
  }

  factory FavouritesList.fromMap(Map<String, dynamic> map) {
    return FavouritesList(
      favourites: List<BreedsModel>.from(map['favourites']?.map((x) => BreedsModel.fromJsom(x))),
    );
  }


  factory FavouritesList.fromJson(String source) => FavouritesList.fromMap(json.decode(source));

  @override
  List<Object> get props => [favourites];
}
