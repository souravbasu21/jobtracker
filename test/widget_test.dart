import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobtracker/app.dart';
import 'package:jobtracker/repositories/job_repository.dart';

void main() {
  testWidgets('adds a job application', (WidgetTester tester) async {
    await tester.pumpWidget(JobTrackerApp(repository: JobRepository()));

    expect(find.text('No jobs here yet'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pumpAndSettle();

    await tester.enterText(find.bySemanticsLabel('Company'), 'Acme Studio');
    await tester.enterText(find.bySemanticsLabel('Role'), 'Flutter Engineer');
    await tester.enterText(find.bySemanticsLabel('Location'), 'Remote');

    await tester.tap(find.text('Create Job'));
    await tester.pumpAndSettle();

    expect(find.text('Acme Studio'), findsOneWidget);
    expect(find.text('Flutter Engineer'), findsOneWidget);
    expect(find.text('Remote'), findsOneWidget);
  });
}
