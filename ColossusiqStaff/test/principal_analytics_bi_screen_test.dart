import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_analytics_bi_screen.dart';

void main() {
  testWidgets('analytics charts use the available width on mobile', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PrincipalAnalyticsBiScreen())),
    );
    await tester.pumpAndSettle();

    void expectChartToFillWidth(String title) {
      final chartCard = find
          .ancestor(of: find.text(title), matching: find.byType(Container))
          .first;
      expect(tester.getSize(chartCard).width, greaterThan(310));
    }

    expectChartToFillWidth('Weekly academic engagement');
    expectChartToFillWidth('Curriculum delivery modes');
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Employability'));
    await tester.pumpAndSettle();

    expectChartToFillWidth('Placement readiness by department');
    expectChartToFillWidth('Career & placement status');
    expect(tester.takeException(), isNull);
  });
}
