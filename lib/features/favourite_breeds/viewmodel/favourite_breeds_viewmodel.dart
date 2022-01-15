import 'dart:convert';
import 'package:dog_app/features/dog_data/models/breeds.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteBreeds extends ChangeNotifier {
  List<BreedsModel> favouriteBreeds = [];
  SharedPreferences preferences;

  FavouriteBreeds() {
    initializePreferences();
  }

  void initializePreferences() async {
    this.preferences = await SharedPreferences.getInstance();

    String dataToRead = this.preferences.getString("favouriteData");
    if (dataToRead != null) {
      var rawData = jsonDecode(dataToRead) as List;
      favouriteBreeds = List.from(rawData)
          .map<BreedsModel>((item) => BreedsModel.fromMap(item))
          .toList();
    }

    notifyListeners();
  }

  void writeData(List<BreedsModel> data) async {
    String dataToWrite =
        jsonEncode(List<dynamic>.from(data.map((x) => x.toMap())));
    await this.preferences.setString('favouriteData', dataToWrite);
  }

  void addBreed(BreedsModel breed) {
    favouriteBreeds.add(breed);

    writeData(this.favouriteBreeds);

    notifyListeners();
  }

  void removeBreed(BreedsModel breed) {
    favouriteBreeds.remove(breed);

    writeData(this.favouriteBreeds);

    notifyListeners();
  }
}
