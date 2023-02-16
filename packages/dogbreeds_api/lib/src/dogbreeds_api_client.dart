import 'dart:convert';

import 'package:dogbreeds_api/auth/secrets.dart';
import 'package:http/http.dart' as http;

import 'models/breeds_model.dart';


// thrown if an exception occrurs while making an 'http' request.
class HttpException implements Exception {}

//thrown if an http request returns a non-200 status code.
class HttpRequestFailure implements Exception {
  const HttpRequestFailure(this.statusCode);

  final int statusCode;
}

// thrown if an exception occurs while decoding the response body.
class JsonDecodeException implements Exception {}

// thrown if an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}

class DogbreedsApiClient {
  DogbreedsApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<List<BreedsModel>> dogData() async {
    final uri = Uri.parse('https://api.thedogapi.com/v1/breeds');
    http.Response response;

    try {
      response = await _httpClient.get(
        uri,
        headers: {'authorization': myApiKey},
      );
    } on Exception {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    List body;

    try {
      body = jsonDecode(response.body) as List;
    } on Exception {
      throw JsonDecodeException();
    }

    try {
      return body
          .map<BreedsModel>(
            (item) => BreedsModel.fromJsom(item as Map<String, dynamic>),
          )
          .toList();
    } on Exception {
      throw JsonDeserializationException();
    }
  }
}
