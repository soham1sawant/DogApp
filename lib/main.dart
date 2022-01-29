import 'package:dog_app/data/repositories/dog_repository.dart';
import 'package:dog_app/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(App(dogDataRepository: DogRepository())),
    blocObserver: SimpleBlocObserver(),
  );
}
