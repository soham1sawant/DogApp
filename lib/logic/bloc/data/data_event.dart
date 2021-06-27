part of 'data_bloc.dart';

@immutable
abstract class DataEvent extends Equatable {
  DataEvent();

  @override
  List<Object> get props => [];
}

class DataRequested extends DataEvent {}
