import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class DogDataProvider {
  final String _appkey = "00af7d92-3d1c-4860-b0a3-fd060f0eb807";

  Future getData() async {
    final breedsjson = await get(
        Uri.parse("https://api.thedogapi.com/v1/breeds"),
        headers: {HttpHeaders.authorizationHeader: _appkey});
    var rawData = jsonDecode(breedsjson.body);

    return rawData;
  }
}
