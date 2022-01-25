import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dog_app/data/data_providers/dog_data_provider.dart';
import 'package:dog_app/data/models/breeds.dart';

class DogDataRepository {
  final DogDataProvider _dogDataProvider = DogDataProvider();
  final List<BreedsModel> _favouriteBreeds = [];

  Future<List<BreedsModel>> getDogData() async {
    final http.Response _rawDogData = await _dogDataProvider.getRawDogData();
    final json = jsonDecode(_rawDogData.body) as List;
    final List<BreedsModel> breeds = List.from(json)
        .map<BreedsModel>((item) => BreedsModel.fromMap(item))
        .toList();

    return breeds;
  }

  Future<List<BreedsModel>> loadFavourites() {
    return Future.delayed(Duration(milliseconds: 800), () => _favouriteBreeds);
  }

  void addBreedToFavourites(BreedsModel breed) {
    if (_favouriteBreeds.contains(breed) == false) {
      _favouriteBreeds.add(breed);
    }
  }

  void removeBreedFromFavourites(BreedsModel breed) {
    if (_favouriteBreeds.contains(breed)) {
      _favouriteBreeds.remove(breed);
    }
  }
}
