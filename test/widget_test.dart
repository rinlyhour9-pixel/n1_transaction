import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n1_transaction/features/home/home_screen.dart';
import 'package:n1_transaction/features/roles/role_dashboards.dart';
import 'package:n1_transaction/main.dart';

void main() {
  testWidgets('starts at the N1 Logistic welcome screen', (tester) async {
    await tester.pumpWidget(const N1App());

    expect(find.text('Open N1 Logistic'), findsOneWidget);
    expect(find.textContaining('Logistics that'), findsOneWidget);
  });

  testWidgets('driver can complete the role-based entry flow', (tester) async {
    await tester.pumpWidget(const N1App());

    await tester.tap(find.text('Open N1 Logistic'));
    await tester.pumpAndSettle();
    expect(find.text('Select your role'), findsOneWidget);

    await tester.tap(find.text('Driver'));
    await tester.pumpAndSettle();
    expect(find.text('Built for Driver.'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text("Today's assigned trip"), findsOneWidget);
  });

  testWidgets('driver dashboard fits the iPhone 14 Pro Max viewport',
      (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: DriverShell(onThemeChanged: () {}),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Quick actions'), findsOneWidget);
    expect(find.text('Request fuel'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CEO performance chart fits the iPhone 14 Pro Max viewport',
      (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: CeoDashboard(onSwitchRole: () {}),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -420));
    await tester.pumpAndSettle();

    expect(find.text('On-time completion'), findsOneWidget);
    expect(find.text('Sat'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
