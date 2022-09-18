import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dog_app/features/dogbreeds/data/dog_data_provider.dart';

import '../models/breeds/breeds_model.dart';

class DogRepository {
  final DogDataProvider _dogDataProvider = DogDataProvider();
  List<BreedsModel> favouriteBreeds = [];

  Future<List<BreedsModel>> getDogData() async {
    final http.Response rawDogData = await _dogDataProvider.getRawDogData();
    final json = jsonDecode(rawDogData.body) as List;
    final List<BreedsModel> breeds = List.from(json)
        .map<BreedsModel>((item) => BreedsModel.fromJsom(item))
        .toList();

    return breeds;
  }

  Future<List<BreedsModel>> loadFavourites() {
    return Future.delayed(
        const Duration(milliseconds: 800), () => favouriteBreeds);
  }

  void addBreedToFavourites(BreedsModel breed) => favouriteBreeds.add(breed);

  void removeBreedFromFavourites(BreedsModel breed) =>
      favouriteBreeds.remove(breed);
}
