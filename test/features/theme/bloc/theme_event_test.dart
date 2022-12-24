import 'package:dog_app/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
 group("ThemeEvent", () {
    group("ThemeRequestedEvent", () {
      test("supports value comparison", () {
        expect(ThemeRequestedEvent(), ThemeRequestedEvent());
      });
    });
  });
}