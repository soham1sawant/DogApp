part of 'data_bloc.dart';

@immutable
abstract class DataState extends Equatable {
  DataState();

  @override
  List<Object> get props => [];
}

class DataInProgress extends DataState {}

class DataLoadSuccess extends DataState {
  final List<BreedsModel> breeds;

  DataLoadSuccess(this.breeds);

  @override
  List<Object> get props => [breeds];
}

class DataLoadFailure extends DataState {}
