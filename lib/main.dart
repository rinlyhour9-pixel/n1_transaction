import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/auth_flow.dart';
import 'features/home/home_screen.dart';
import 'features/roles/role_dashboards.dart';

void main() => runApp(const N1App());

class N1App extends StatefulWidget {
  const N1App({super.key});
  @override
  State<N1App> createState() => _N1AppState();
}

class _N1AppState extends State<N1App> {
  ThemeMode mode = ThemeMode.light;
  AppRole? authenticatedRole;

  void _signIn(AppRole role) => setState(() => authenticatedRole = role);

  void _switchRole() => setState(() => authenticatedRole = null);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'N1 Logistic',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: mode,
        home: authenticatedRole == null
            ? AuthFlow(onAuthenticated: _signIn)
            : _roleHome(authenticatedRole!),
      );

  void _toggleTheme() => setState(
      () => mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);

  Widget _roleHome(AppRole role) => role == AppRole.driver
      ? DriverShell(onThemeChanged: _toggleTheme, onLogout: _switchRole)
      : RoleShell(
          key: ValueKey(role),
          role: role,
          onSwitchRole: _switchRole,
          onThemeChanged: _toggleTheme,
        );
}
