import 'favourites_data_provider.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';

// TODO: add exception !!

class GetFromFirestoreException implements Exception {}

class WriteToFirestoreException implements Exception {}

class DeleteUserException implements Exception {}

class FavouritesApi {
  final FavouritesDataProvider _favouritesDataProvider =
      FavouritesDataProvider();
  final DogbreedsApiClient _dogbreedsApiClient = DogbreedsApiClient();

  List<BreedsModel> breedsList = [];
  List<String> firestoreList = [];

  List<BreedsModel> favouritesList = [];

  Future<List<BreedsModel>> loadFavourites() async {
    breedsList = await _dogbreedsApiClient.dogData();

    // execute getFromFireStore() from data provider
    // update firestoreList to this data
    try {
      firestoreList = await _favouritesDataProvider.getFromFireStore();
    } on Exception {
      throw GetFromFirestoreException();
    }

    // run a for loop to match the name of dog from firestoreList
    //and breedsList.if true, add too favouritesList
    for (var i = 0; i < breedsList.length; i++) {
      if (firestoreList.contains(breedsList[i].name)) {
        favouritesList.add(breedsList[i]);
      }
    }
    return favouritesList;
  }

  Future<void> addBreedToFavourites(BreedsModel breed) async {
    // check if breed is already present in favouritesList
    if (favouritesList.contains(breed) == false) {
      // if no then add breed to favouritesList
      favouritesList.add(breed);

      // add breed.name to firestoreList
      firestoreList.add(breed.name);

      // execute writeToFirestore(firestoreList)
      try {
        await _favouritesDataProvider.writeToFireStore(firestoreList);
      } on Exception {
        throw WriteToFirestoreException();
      }
    }
  }

  Future<void> removeBreedFromFavourites(BreedsModel breed) async {
    // check if favouritesList contains breed
    if (favouritesList.contains(breed)) {
      // if yes then, remove breed from favouritesList
      favouritesList.remove(breed);

      // remove favouritesList.name from firestoreList
      firestoreList.remove(breed.name);

      // execute writeToFirestore(firestoreList)
      try {
        await _favouritesDataProvider.writeToFireStore(firestoreList);
      } on Exception {
        throw WriteToFirestoreException();
      }
    }
  }

  Future<void> deleteUserFromFirestore() async {
    try {
      await _favouritesDataProvider.deleteUserFromFireStore();
    } on Exception {
      throw DeleteUserException();
    }
  }
}
