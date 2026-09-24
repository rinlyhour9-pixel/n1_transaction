import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/language_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.onThemeChanged,
    this.onLogout,
    this.name = 'Dara Sok',
    this.accountLabel = 'Driver ID · DR-001',
    this.isDriver = true,
    required this.locale,
    required this.onLocaleChanged,
  });
  final VoidCallback onThemeChanged;
  final VoidCallback? onLogout;
  final String name, accountLabel;
  final bool isDriver;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name = widget.name;

  Future<void> _editProfile() async {
    final l10n = AppLocalizations.of(context)!;
    var editedName = name;
    final formKey = GlobalKey<FormState>();
    final updated = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.personalInfo),
        content: Form(
          key: formKey,
          child: TextFormField(
            initialValue: name,
            onChanged: (value) => editedName = value,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: l10n.fullName),
            validator: (value) => value == null || value.trim().isEmpty
                ? l10n.enterYourName
                : null,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel)),
          FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context, editedName.trim());
                }
              },
              child: Text(l10n.save)),
        ],
      ),
    );
    if (mounted && updated != null) setState(() => name = updated);
  }

  Future<void> _selectLanguage(BuildContext anchorContext) =>
      showLanguagePicker(anchorContext, widget.locale, widget.onLocaleChanged);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final muted = dark ? Colors.white60 : const Color(0xFF677087);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor:
            dark ? const Color(0xFF111C2C) : const Color(0xFFF3F7FB),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 185 + MediaQuery.paddingOf(context).top,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(28)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF124B91), Color(0xFF2169B6)],
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(children: [
                  Positioned(
                      right: -65,
                      bottom: -140,
                      child: Container(
                          width: 290,
                          height: 290,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: .06)))),
                ]),
              ),
              SafeArea(
                bottom: false,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(l10n.profileTitle,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 4),
                                  Text(l10n.profileSubtitle,
                                      style: const TextStyle(
                                          color: Color(0xFFD4E5FA),
                                          fontSize: 14)),
                                ],
                              )),
                              const SizedBox(width: 8),
                              IconButton.filled(
                                tooltip: l10n.editProfile,
                                onPressed: _editProfile,
                                style: IconButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withValues(alpha: .23),
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(44, 44)),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 24),
                          _Panel(
                              child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(children: [
                              Stack(children: [
                                CircleAvatar(
                                    radius: 39,
                                    backgroundColor: AppColors.navy,
                                    child: Text(
                                        name
                                            .split(RegExp(r'\s+'))
                                            .where((part) => part.isNotEmpty)
                                            .take(2)
                                            .map((part) => part[0])
                                            .join(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w700))),
                                Positioned(
                                    bottom: 1,
                                    right: 0,
                                    child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF0AB779),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                width: 3)))),
                              ]),
                              const SizedBox(width: 20),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(name,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 5),
                                    Text(widget.accountLabel,
                                        style: TextStyle(
                                            color: muted, fontSize: 14)),
                                    const SizedBox(height: 10),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF0AB779)
                                                .withValues(alpha: .10),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                  widget.isDriver
                                                      ? Icons
                                                          .local_shipping_outlined
                                                      : Icons
                                                          .verified_user_outlined,
                                                  color:
                                                      const Color(0xFF009568),
                                                  size: 19),
                                              const SizedBox(width: 7),
                                              Flexible(
                                                  child: Text(
                                                      widget.isDriver
                                                          ? l10n.activeDriver
                                                          : l10n.activeAccount,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFF009568),
                                                          fontWeight: FontWeight
                                                              .w600))),
                                            ])),
                                  ])),
                            ]),
                          )),
                          if (widget.isDriver) ...[
                            const SizedBox(height: 12),
                            _Panel(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 2),
                              child: Column(children: [
                                _Detail(
                                    icon: Icons.phone_outlined,
                                    label: l10n.phone,
                                    value: '+855 12 345 678'),
                                const Divider(height: 1),
                                _Detail(
                                    icon: Icons.badge_outlined,
                                    label: l10n.licenseNumber,
                                    value: 'KHM-DL-104293'),
                                const Divider(height: 1),
                                _Detail(
                                    icon: Icons.local_shipping_outlined,
                                    label: l10n.assignedVehicleLabel,
                                    value: 'PP 3A-1234'),
                              ]),
                            )),
                          ],
                          const SizedBox(height: 20),
                          Text(l10n.settings,
                              style: TextStyle(
                                  color: muted,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
                          const SizedBox(height: 9),
                          _Menu(
                              icon: Icons.person_outline,
                              label: l10n.personalInfo,
                              subtitle: l10n.personalInfoSubtitle,
                              color: const Color(0xFF0759AA),
                              onTap: _editProfile),
                          _Menu(
                              icon: Icons.lock_outline,
                              label: l10n.changePassword,
                              subtitle: l10n.changePasswordSubtitle,
                              color: const Color(0xFF009568)),
                          Builder(
                              builder: (menuContext) => _Menu(
                                  icon: Icons.language,
                                  label: l10n.language,
                                  subtitle: l10n.languageSubtitle,
                                  color: const Color(0xFF7131D5),
                                  detail: widget.locale.languageCode == 'km'
                                      ? l10n.languageKhmer
                                      : l10n.languageEnglish,
                                  onTap: () => _selectLanguage(menuContext))),
                          _Menu(
                              icon: Icons.dark_mode_outlined,
                              label: l10n.toggleTheme,
                              subtitle: l10n.toggleThemeSubtitle,
                              color: const Color(0xFFE79300),
                              onTap: widget.onThemeChanged),
                          _Menu(
                              icon: Icons.help_outline,
                              label: l10n.helpSupport,
                              subtitle: l10n.helpSupportSubtitle,
                              color: const Color(0xFFED263B)),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    _logout(context, widget.onLogout),
                                icon: const Icon(Icons.logout),
                                label: Text(l10n.logOut),
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFFFF3038),
                                    minimumSize: const Size.fromHeight(48),
                                    side: const BorderSide(
                                        color: Color(0xFFFF3038)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1B2B40)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: .06)),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF264D78).withValues(alpha: .035),
                blurRadius: 18,
                offset: const Offset(0, 5))
          ],
        ),
        child: child,
      );
}

class _IconTile extends StatelessWidget {
  const _IconTile(this.icon, this.color);
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: color.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: color, size: 24),
      );
}

class _Detail extends StatelessWidget {
  const _Detail({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Row(children: [
          _IconTile(icon, const Color(0xFF0759AA)),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(label,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 13)),
                const SizedBox(height: 3),
                Text(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
              ])),
          const Icon(Icons.chevron_right, size: 21),
        ]),
      );
}

class _Menu extends StatelessWidget {
  const _Menu(
      {required this.icon,
      required this.label,
      required this.subtitle,
      required this.color,
      this.detail,
      this.onTap});
  final IconData icon;
  final String label, subtitle;
  final Color color;
  final String? detail;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: _Panel(
            child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(children: [
                _IconTile(icon, color),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(label,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14)),
                      const SizedBox(height: 3),
                      Text(subtitle,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontSize: 12)),
                    ])),
                if (detail != null) ...[
                  const SizedBox(width: 6),
                  Text(detail!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12))
                ],
                const SizedBox(width: 6),
                const Icon(Icons.chevron_right, size: 21),
              ]),
            ),
          ),
        )),
      );
}

void _logout(BuildContext context, VoidCallback? onLogout) {
  final l10n = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.logOutTitle),
      content: Text(l10n.logOutBody),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel)),
        FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onLogout?.call();
            },
            child: Text(l10n.logOut)),
      ],
    ),
  );
}
