import 'package:bloc/bloc.dart';
import 'package:dog_app/features/theme/data/theme_repository.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository themeRepository;

  ThemeBloc(this.themeRepository) : super(ThemeLoading()) {
    on<ThemeEvent>((event, emit) {
      if (event is ThemeRequestedEvent) {
        emit(ThemeLoading());

        try {
          final response = themeRepository.getThemeData();
          emit(ThemeLoaded(response));
        } catch (_) {
          emit(ThemeLoadingError());
        }
      }
    });
  }
}
