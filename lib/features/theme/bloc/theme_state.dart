part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeLoading extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded(this.isDarkTheme);

  final bool isDarkTheme;

  @override
  List<Object> get props => [isDarkTheme];
}

class ThemeLoadingError extends ThemeState {
  @override
  List<Object> get props => [];
}
