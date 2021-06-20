import 'dart:async';

import '../../data/models/breeds.dart';
import '../../data/repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataRepository _dataRepository;

  DataBloc(this._dataRepository) : super(DataInProgress());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataRequested) {
      try {
        final data = await _dataRepository.getDogData();
        yield DataLoadSuccess(data);
      } catch (error) {
        yield DataLoadFailure();
      }
    }
  }
}
