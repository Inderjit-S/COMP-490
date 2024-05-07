import 'package:aerogotchi/main.dart' as app;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aerogotchi/screen/loginscreen.dart';
import 'package:aerogotchi/screen/petnamescreen.dart';
import 'package:aerogotchi/screen/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("Login Test", (tester) async {
      // Launch the app
      await tester.pumpWidget(const app.MyApp());

      //Testing for IdleScreen
      /*final screenSize = tester.binding.window.physicalSize; //Get screen size
      final centerX = screenSize.width / 2;
      final centerY = screenSize.height / 2;
      await tester.tapAt(Offset(centerX, centerY)); //Tap anywhere on IdleScreen
      await tester.pumpAndSettle();*/


      // Testing for LoginScreen Find email , password, login button
     /*expect(find.byType(LoginScreen), findsOneWidget);
     final emailFormField = find.byType(TextField).first;
     final passwordFormField = find.byType(TextField).last;
     final loginButton = find.byType(ElevatedButton).first;
     expect(emailFormField, findsOneWidget);
     expect(passwordFormField,findsOneWidget);
     expect(loginButton, findsOneWidget);
     await tester.enterText(emailFormField, "qqq@q.com");
     await Future.delayed(const Duration(seconds: 1));
     await tester.enterText(passwordFormField, '123456');
     await Future.delayed(const Duration(seconds: 1));
     await tester.tap(loginButton);
     await tester.pumpAndSettle();*/

     //Testing for Signup
     expect(find.byType(SignUpScreen), findsOneWidget);
     final emailFormField = find.byType(TextField).first;
     final passwordFormField = find.byType(TextField).last;
     final SignupButton = find.byType(ElevatedButton).first;
     expect(emailFormField, findsOneWidget);
     expect(passwordFormField,findsOneWidget);
     expect(SignupButton, findsOneWidget);
     await tester.enterText(emailFormField, "testing@gmail.com");
     await Future.delayed(const Duration(seconds: 1));
     await tester.enterText(passwordFormField, '123456');
     await Future.delayed(const Duration(seconds: 1));
     await tester.tap(SignupButton);
     await tester.pumpAndSettle();
    });
  });
}