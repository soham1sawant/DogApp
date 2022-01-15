import 'package:dog_app/features/dog_data/models/breeds.dart';
import 'package:dog_app/features/dog_data/services/dog_data_service.dart';
import 'package:flutter/foundation.dart';

class DogData extends ChangeNotifier {
  List<BreedsModel> dogbreeds;

  DogData() {
    _getDogBreeds();
  }

  void _getDogBreeds() async {
    final dogData = DogDataService();
    dogbreeds = await dogData.fetchBreeds();
    notifyListeners();
  }

}
