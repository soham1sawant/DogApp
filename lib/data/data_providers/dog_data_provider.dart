import 'dart:io';
import 'package:http/http.dart' as http;

class DogDataProvider {
  final String _appkey = "00af7d92-3d1c-4860-b0a3-fd060f0eb807";

  Future<http.Response> getRawDogData() async {
    http.Response response = await http.get(
        Uri.parse("https://api.thedogapi.com/v1/breeds"),
        headers: {HttpHeaders.authorizationHeader: _appkey});

    return response;
  }
}
