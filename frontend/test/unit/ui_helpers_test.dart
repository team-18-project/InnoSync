import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/utils/ui_helpers.dart';

void main() {
  late Widget testWidget;

  setUp(() {
    testWidget = MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () => UIHelpers.showError(context, 'Test Error'),
            child: const Text('Trigger Error'),
          ),
        ),
      ),
    );
  });

  testWidgets('showError displays SnackBar', (tester) async {
    await tester.pumpWidget(testWidget);
    await tester.tap(find.text('Trigger Error'));
    await tester.pump(); // Allow SnackBar to appear

    expect(find.text('Test Error'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('showConfirmationDialog works', (tester) async {
    bool? result;
    testWidget = MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              result = await UIHelpers.showConfirmationDialog(
                  context,
                  'Confirm',
                  'Are you sure?'
              );
            },
            child: const Text('Show Dialog'),
          ),
        ),
      ),
    );

    await tester.pumpWidget(testWidget);
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure?'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    expect(result, true);
  });

  testWidgets('showLoadingDialog and hideLoadingDialog work', (tester) async {
    testWidget = MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => Column(
            children: [
              TextButton(
                onPressed: () => UIHelpers.showLoadingDialog(context, 'Loading...'),
                child: const Text('Show Loading'),
              ),
              TextButton(
                onPressed: () => UIHelpers.hideLoadingDialog(context),
                child: const Text('Hide Loading'),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpWidget(testWidget);
    await tester.tap(find.text('Show Loading'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);

    await tester.tap(find.text('Hide Loading'));
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}