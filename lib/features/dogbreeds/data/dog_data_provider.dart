import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/auth/secrets.dart';

class DogDataProvider {

  Future<http.Response> getRawDogData() async {
    http.Response response = await http.get(
        Uri.parse("https://api.thedogapi.com/v1/breeds"),
        headers: {HttpHeaders.authorizationHeader: '$API_KEY'});

    return response;
  }
}
