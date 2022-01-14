import 'dart:convert';
import 'dart:io';
import 'package:dog_app/2viewmodel/favourite_breeds_viewmodel.dart';
import 'package:dog_app/3model/models/breeds.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Testing Favourite Breeds", () {
    var favs = FavouriteBreeds();

    final String response =
        File("test/3model/models/data_dog.json").readAsStringSync();
    List rawData = jsonDecode(response) as List;
    List<BreedsModel> breeds = List.from(rawData)
        .map<BreedsModel>((item) => BreedsModel.fromMap(item))
        .toList();

    test("Checking if Favourites is empty", () {
      expect(favs.favouriteBreeds.length, 0);
    });

    test("Adding 1 item to Favourites", () {
      favs.addBreed(breeds[0]);
      expect(favs.favouriteBreeds[0].id, 1);
    });

    test("Removing 1 item to Favourites", () {
      favs.removeBreed(favs.favouriteBreeds[0]);
      expect(favs.favouriteBreeds.length, 0);
    });
  });
}
