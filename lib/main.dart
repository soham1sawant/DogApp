import 'package:dog_app/data/repositories/dog_repository.dart';
import 'package:dog_app/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(App(dogDataRepository: DogRepository())),
    storage: storage,
    blocObserver: SimpleBlocObserver(),
  );
}
