import 'package:dog_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/features/authentication/ui/sign_in_page_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets('runs through full app', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      loadSignInPageCheck();
    });
  });
}
