import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/auth_flow.dart';
import 'features/home/home_screen.dart';
import 'features/roles/role_dashboards.dart';
import 'l10n/generated/app_localizations.dart';

void main() => runApp(const N1App());

class N1App extends StatefulWidget {
  const N1App({super.key});
  @override
  State<N1App> createState() => _N1AppState();
}

class _N1AppState extends State<N1App> {
  ThemeMode mode = ThemeMode.light;
  Locale locale = const Locale('en');
  AppRole? authenticatedRole;

  void _signIn(AppRole role) => setState(() => authenticatedRole = role);

  void _switchRole() => setState(() => authenticatedRole = null);

  void _changeLocale(Locale value) => setState(() => locale = value);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'N1 TRANSPORTATION',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(locale: locale),
        darkTheme: AppTheme.dark(locale: locale),
        themeMode: mode,
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: authenticatedRole == null
            ? AuthFlow(
                onAuthenticated: _signIn,
                locale: locale,
                onLocaleChanged: _changeLocale,
              )
            : _roleHome(authenticatedRole!),
      );

  void _toggleTheme() => setState(
      () => mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);

  Widget _roleHome(AppRole role) => role == AppRole.driver
      ? DriverShell(
          onThemeChanged: _toggleTheme,
          onLogout: _switchRole,
          locale: locale,
          onLocaleChanged: _changeLocale,
        )
      : RoleShell(
          key: ValueKey(role),
          role: role,
          onSwitchRole: _switchRole,
          onThemeChanged: _toggleTheme,
          locale: locale,
          onLocaleChanged: _changeLocale,
        );
}
