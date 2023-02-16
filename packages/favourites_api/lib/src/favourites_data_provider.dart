import 'dart:developer';

import 'models/favourites_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FavouritesDataProvider {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  Future<void> writeToFireStore(List<String> favouritesList) async {
    final userRef = db.collection('favourites').doc(firebaseUser?.uid);

    final favouritesModel = FavouritesModel(likes: favouritesList);
    await userRef.set(favouritesModel.toJson());
  }

  Future<List<String>> getFromFireStore() async {
    final userRef = db.collection('favourites').doc(firebaseUser?.uid);

    final docSnapshot;
    
    try {
      await db.disableNetwork();
      await db.enableNetwork();
      docSnapshot = await userRef.get();

      if (docSnapshot.exists && (docSnapshot.data() != null)) {
        final data = FavouritesModel.fromJson(docSnapshot.data());

        return data.likes;
      } else {
        final favouritesModel = FavouritesModel(likes: []);
        await userRef.set(favouritesModel.toJson());

        return <String>[];
      }
    } catch (e) {
      log(e.toString());
    }

    return <String>[];
  }
}
