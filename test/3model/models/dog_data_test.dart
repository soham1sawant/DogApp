import 'dart:convert';
import 'dart:io';

import 'package:dog_app/data/models/breeds.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Testing Dog Model", () async {
    final String response =
        File("test/3model/models/data_dog.json").readAsStringSync();
    List rawData = jsonDecode(response) as List;
    List<BreedsModel> breeds = List.from(rawData)
        .map<BreedsModel>((item) => BreedsModel.fromMap(item))
        .toList();

    expect(breeds[0].name, "Affenpinscher");
    expect(breeds[0].weight.imperial, "6 - 13");
    expect(breeds[0].id, 1);

    expect(breeds[1].name, "Afghan Hound");
    expect(breeds[1].weight.imperial, "50 - 60");
    expect(breeds[1].id, 2);
  });
}
