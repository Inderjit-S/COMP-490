import 'package:aerogotchi/main.dart' as app;
import 'package:aerogotchi/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("Login Test", (tester) async {
      // Launch the app
      await tester.pumpWidget(app.MyApp());

      final screenSize = tester.binding.window.physicalSize; //Get screen size
      final centerX = screenSize.width / 2;
      final centerY = screenSize.height / 2;
      await tester.tapAt(Offset(centerX, centerY)); //Tap anywhere on IdleScreen
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);


      // Find email , password, login button on LoginScreen
     final emailFormField = find.byType(TextField).first;
     final passwordFormField = find.byType(TextField).first;
     final loginButton = find.byType(Container).first;
     final signupButton = find.byType(Row).first;

     //await tester.enterText(emailFormField, "qqq@q.com");
     //await tester.enterText(passwordFormField, '123456');

     //await tester.pumpAndSettle();
     //await tester.tap(loginButton);
      // Tap the login button
     // await tester.enterText(emailFormField, "flutter_test@gmail.com");
     // await tester.enterText(passwordFormField, "123456");
      //await tester.tap(find.textContaining('LOG IN'));

      // Wait for the app to settle


      // Verify that the PetViewScreen is displayed
      //expect(find.byType(PetViewScreen), findsOneWidget);
    });
  });
}