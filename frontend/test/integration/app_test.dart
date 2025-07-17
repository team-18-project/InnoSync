import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:your_app_name/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end tests', () {
    testWidgets('Complete user flow: sign up, login, and navigate app',
            (WidgetTester tester) async {
          // Launch the app
          app.main();
          await tester.pumpAndSettle();

          // Verify we're on the login screen
          expect(find.text('InnoSync'), findsOneWidget);
          expect(find.text('We work it together !'), findsOneWidget);

          // Switch to Sign Up tab
          await tester.tap(find.text('Sign Up'));
          await tester.pumpAndSettle();

          // Enter sign up credentials
          final emailField = find.byType(TextFormField).first;
          final passwordField = find.byType(TextFormField).last;

          await tester.enterText(emailField, 'testuser@example.com');
          await tester.enterText(passwordField, 'Test1234!');
          await tester.pump();

          // Tap sign up button
          await tester.tap(find.text('Sign Up'));
          await tester.pumpAndSettle();

          // Verify we're on the create profile page after sign up
          expect(find.text('Create Profile'), findsOneWidget);

          // Go back to login (simulating profile creation completion)
          await tester.pageBack();
          await tester.pumpAndSettle();

          // Now test login flow
          await tester.tap(find.text('Log In'));
          await tester.pumpAndSettle();

          // Enter login credentials
          await tester.enterText(emailField, 'testuser@example.com');
          await tester.enterText(passwordField, 'Test1234!');
          await tester.pump();

          // Tap login button
          await tester.tap(find.text('Log In'));
          await tester.pumpAndSettle();

          // Verify we're on the main page
          expect(find.byType(BottomNavigationBar), findsOneWidget);
          expect(find.text('Discover'), findsOneWidget);

          // Test navigation between tabs
          await tester.tap(find.text('My Projects'));
          await tester.pumpAndSettle();
          expect(find.text('My Projects'), findsOneWidget);

          await tester.tap(find.text('Dashboard'));
          await tester.pumpAndSettle();
          expect(find.text('Dashboard'), findsOneWidget);

          await tester.tap(find.text('Discover'));
          await tester.pumpAndSettle();
          expect(find.text('Discover'), findsOneWidget);
        });

    testWidgets('Test project selection flow', (WidgetTester tester) async {
      // Launch the app and login directly (assuming mock data is set up)
      app.main();
      await tester.pumpAndSettle();

      // Simulate login (in a real test, you'd need to mock the auth state)
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;

      await tester.enterText(emailField, 'existinguser@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      // Verify we're on the main page
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Tap on a project (assuming there's at least one in the mock data)
      final projectFinder = find.byKey(const Key('project_item_0'));
      await tester.ensureVisible(projectFinder);
      await tester.tap(projectFinder);
      await tester.pumpAndSettle();

      // Verify we're on the project view
      expect(find.byType(ProjectView), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsNothing);

      // Go back to discover page
      final backButton = find.byIcon(Icons.arrow_back);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Verify we're back to discover with bottom nav
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('Test invalid login attempts', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Verify we're on the login screen
      expect(find.text('InnoSync'), findsOneWidget);

      // Try to login with non-existing email
      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;

      await tester.enterText(emailField, 'nonexisting@example.com');
      await tester.enterText(passwordField, 'wrongpassword');
      await tester.pump();

      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(find.text('Account not found. Please sign up.'), findsOneWidget);

      // Switch to Sign Up tab and try with existing email
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      await tester.enterText(emailField, 'existinguser@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(find.text('Account already exists. Please log in.'), findsOneWidget);
    });
  });
}