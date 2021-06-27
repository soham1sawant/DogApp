part of 'favouritebutton_cubit.dart';

abstract class FavouriteButtonState extends Equatable {
  const FavouriteButtonState();

  @override
  List<Object> get props => [];
}

class FavouriteButtonPressed extends FavouriteButtonState {}

class FavouriteButtonDepressed extends FavouriteButtonState {}