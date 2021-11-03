import '../data/models/breeds.dart';
import 'package:flutter/foundation.dart';

class FavouriteBreeds extends ChangeNotifier {
  List<BreedsModel> favouriteBreeds = [];

  void addBreed(BreedsModel breed) {
    favouriteBreeds.add(breed);
    notifyListeners();
  }

  void removeBreed(BreedsModel breed) {
    favouriteBreeds.remove(breed);
    notifyListeners();
  }
}
