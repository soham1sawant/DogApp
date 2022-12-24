import 'package:dog_app/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ThemeState", () {
    group("ThemeLoading", () {
      test("supports value comparison", () {
        expect(ThemeLoading(), ThemeLoading());
      });
    });

    group("ThemeLoaded", () {
      test("supports value comparison", () {
        expect(const ThemeLoaded(false), const ThemeLoaded(false));
      });
    });

    group("ThemeLoadingError", () {
      test("supports value comparison", () {
        expect(ThemeLoadingError(), ThemeLoadingError());
      });
    });
  });
}