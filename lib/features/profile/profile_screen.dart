import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/ui_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.onThemeChanged,
    this.onLogout,
  });
  final VoidCallback onThemeChanged;
  final VoidCallback? onLogout;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.navy,
                    child: Text(
                      'DS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dara Sok',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'Driver ID · DR-001',
                    style: TextStyle(color: AppColors.muted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
                    InfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: '+855 12 345 678',
                    ),
                    Divider(height: 1),
                    InfoRow(
                      icon: Icons.badge_outlined,
                      label: 'License number',
                      value: 'KHM-DL-104293',
                    ),
                    Divider(height: 1),
                    InfoRow(
                      icon: Icons.local_shipping_outlined,
                      label: 'Assigned vehicle',
                      value: 'PP 3A-1234',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _Menu(icon: Icons.person_outline, label: 'Personal information'),
            _Menu(icon: Icons.lock_outline, label: 'Change password'),
            _Menu(
              icon: Icons.language_outlined,
              label: 'Language',
              detail: 'English',
            ),
            _Menu(
              icon: Icons.dark_mode_outlined,
              label: 'Toggle theme',
              onTap: onThemeChanged,
            ),
            _Menu(icon: Icons.help_outline, label: 'Help & support'),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _logout(context, onLogout),
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: const Text(
                'Log out',
                style: TextStyle(color: AppColors.error),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                side: const BorderSide(color: AppColors.error),
              ),
            ),
          ],
        ),
      );
}

void _logout(BuildContext context, VoidCallback? onLogout) => showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log out?'),
        content:
            const Text('You will need to sign in again to access your trips.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onLogout?.call();
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );

class _Menu extends StatelessWidget {
  const _Menu({
    required this.icon,
    required this.label,
    this.detail,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final String? detail;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: AppColors.navy),
          title:
              Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          trailing: detail == null
              ? const Icon(Icons.chevron_right)
              : Text(detail!, style: const TextStyle(color: AppColors.muted)),
        ),
      );
}
