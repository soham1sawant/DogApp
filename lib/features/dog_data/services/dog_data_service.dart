import 'dart:convert';
import 'dart:io';
import 'package:dog_app/features/dog_data/models/breeds.dart';
import 'package:http/http.dart';

class DogDataService {
  List<BreedsModel> breeds;

  Future<List<BreedsModel>> fetchBreeds() async {
    final String _appkey = "00af7d92-3d1c-4860-b0a3-fd060f0eb807";

    try {
      final response = await get(
          Uri.parse("https://api.thedogapi.com/v1/breeds"),
          headers: {HttpHeaders.authorizationHeader: _appkey});

      if (response.statusCode == 200) {
        var rawData = jsonDecode(response.body) as List;
        breeds = List.from(rawData)
            .map<BreedsModel>((item) => BreedsModel.fromMap(item))
            .toList();
      }
    } catch (e) {
      print(e);
      
      return null;
    }
    return breeds;
  }
}
