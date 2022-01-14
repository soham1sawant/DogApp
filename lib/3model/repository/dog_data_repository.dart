import 'package:dog_app/3model/models/breeds.dart';
import 'package:dog_app/3model/service/dog_data_service.dart';

class DogDataRepository {
  DogDataService _dogDataService;

  Future<List<BreedsModel>> forwardData() async {
    List _fetchedBreeds = await _dogDataService.fetchBreeds();
    return _fetchedBreeds;
  }
}
