import 'package:flutter/foundation.dart';

import 'package:dog_app/data/models/breeds.dart';
import 'package:dog_app/data/repository/data_repository.dart';

class LoadBreeds extends ChangeNotifier {
  List<BreedsModel> breeds = [];

  getData() async {
    DataRepository _dataRepository = DataRepository();
    breeds = await _dataRepository.getDogData();
  }

  LoadBreeds({this.breeds}) {
    getData();
  }
}
