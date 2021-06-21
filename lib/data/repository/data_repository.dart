import '../data_provider/dog_data_provider.dart';
import '../models/breeds.dart';

class DataRepository {
  final _dataProvider = DogDataProvider();

  Future<List<BreedsModel>> getDogData() async{
    final decodedJson = await _dataProvider.getData() as List;
    List<BreedsModel> breeds = List.from(decodedJson)
        .map<BreedsModel>((item) => BreedsModel.fromJson(item))
        .toList();

    return breeds;
  }
}
