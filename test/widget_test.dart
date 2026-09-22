import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n1_transaction/features/home/home_screen.dart';
import 'package:n1_transaction/features/roles/role_dashboards.dart';
import 'package:n1_transaction/main.dart';
import 'package:n1_transaction/features/trips/trip_screens.dart';
import 'package:n1_transaction/shared/widgets/ui_components.dart';
import 'package:n1_transaction/features/profile/profile_screen.dart';
import 'package:n1_transaction/features/auth/auth_flow.dart';

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

    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text("Today's assigned trip"), findsOneWidget);
  });

  for (final role in [
    AppRole.tripAdviser,
    AppRole.fuelStockManager,
    AppRole.ceo
  ]) {
    testWidgets('${role.label} navigation opens the correct profile',
        (tester) async {
      tester.view.physicalSize = const Size(430, 932);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(MaterialApp(
          home: RoleShell(
        role: role,
        onSwitchRole: () {},
        onThemeChanged: () {},
      )));
      await tester.pumpAndSettle();
      expect(find.byType(AppNavigationBar), findsOneWidget);
      await tester.tap(find.byTooltip('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('${role.label} · ${role.demoAccount}'), findsOneWidget);
      expect(find.text('Driver ID · DR-001'), findsNothing);
      await tester.tap(find.byTooltip('Notifications'));
      await tester.pumpAndSettle();
      expect(find.text('No new notifications'), findsOneWidget);
      await tester.tap(find.byTooltip('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Good morning,'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('profile fits a phone and validates name edits', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester
        .pumpWidget(MaterialApp(home: ProfileScreen(onThemeChanged: () {})));
    expect(find.text('Active Driver'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byTooltip('Edit profile'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '   ');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Enter your name'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Dara Chan');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Dara Chan'), findsOneWidget);
    expect(find.text('DC'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('redesigned trip details fit a phone and can start a trip',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: TripDetailScreen()));
    expect(find.text('N1-2034'), findsOneWidget);
    expect(find.text('25 Tons'), findsOneWidget);
    expect(find.text('PP 3A-1234'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Start trip'));
    await tester.tap(find.text('Start trip'));
    await tester.pumpAndSettle();
    expect(find.text('Start this trip?'), findsOneWidget);
    await tester.tap(find.text('Yes, start trip'));
    await tester.pumpAndSettle();
    expect(find.text('Active trip'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Arrived at pickup').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start loading').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm loading').last);
    await tester.pumpAndSettle();
    expect(find.text('Actual quantity'), findsOneWidget);
    expect(tester.takeException(), isNull);
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
