import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'trip_presentation.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';

/// A branded navy AppBar with a curved bottom edge, used on secondary
/// pages in place of a flat default AppBar so their top chrome matches
/// the app's other branded headers.
PreferredSizeWidget curvedAppBar(String title, {List<Widget>? actions}) =>
    AppBar(
      title: Text(title),
      // The theme's AppBarTheme.titleTextStyle hardcodes a dark color for
      // the app's other (light) app bars, which would silently override
      // foregroundColor here — so the title style must be set explicitly.
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w800,
      ),
      backgroundColor: AppColors.navy,
      foregroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 64,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(26))),
      actions: actions,
    );

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
        height: 54,
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : icon == null
                  ? const SizedBox.shrink()
                  : Icon(icon),
          label: Text(
            isLoading ? l10n.pleaseWait : label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
            elevation: 0,
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ).copyWith(
            overlayColor:
                WidgetStatePropertyAll(Colors.white.withValues(alpha: .12)),
            elevation: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.pressed) ? 0 : 1,
            ),
          ),
        ),
      );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {super.key, required this.label, required this.onPressed, this.icon});
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 52,
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: icon == null ? const SizedBox.shrink() : Icon(icon),
          label: Text(label),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.navy.withValues(alpha: .10),
            foregroundColor: AppColors.navy,
            elevation: 0,
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );
}

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton(
      {super.key, required this.label, required this.onPressed, this.icon});
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 52,
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon == null ? const SizedBox.shrink() : Icon(icon),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.navy,
            side: BorderSide(color: AppColors.navy.withValues(alpha: .35)),
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onTap,
  });
  final String title;
  final String? action;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          if (action != null)
            TextButton(onPressed: onTap, child: Text(action!)),
        ],
      );
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    this.color = AppColors.blue,
  });
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      );
}

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });
  final String value, label;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
}

class MetricGrid extends StatelessWidget {
  const MetricGrid({super.key, required this.children, this.height = 118});
  final List<Widget> children;
  final double height;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final columns = children.length.clamp(1, 4);
          final width = (constraints.maxWidth - (columns - 1) * 10) / columns;
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final child in children)
                SizedBox(width: width, height: height, child: child),
            ],
          );
        },
      );
}

/// A compact action grid that keeps each tap target comfortably readable on
/// phone-sized screens, including the 430 pt wide iPhone 14 Pro Max.
class ActionGrid extends StatelessWidget {
  const ActionGrid({
    super.key,
    required this.children,
    this.itemHeight = 108,
  });

  final List<Widget> children;
  final double itemHeight;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final columns = children.length.clamp(1, 4);
          final width =
              (constraints.maxWidth - (columns - 1) * AppSpacing.sm) / columns;

          return Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final child in children)
                SizedBox(width: width, height: itemHeight, child: child),
            ],
          );
        },
      );
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.muted),
            const SizedBox(width: 12),
            Expanded(
              child:
                  Text(label, style: const TextStyle(color: AppColors.muted)),
            ),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      );
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, required this.message});
  final String title, message;
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.inbox_outlined,
                  size: 48, color: AppColors.muted),
              const SizedBox(height: 12),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.muted),
              ),
            ],
          ),
        ),
      );
}

/// Shared icon-only navigation, with labels retained for accessibility.
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Material(
      color: dark ? const Color(0xFF1B2B40) : Colors.white,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 76,
          child: Row(
            children: List.generate(destinations.length, (index) {
              final destination = destinations[index];
              final selected = index == selectedIndex;
              return Expanded(
                child: Semantics(
                  label: destination.label,
                  button: true,
                  selected: selected,
                  child: Tooltip(
                    message: destination.label,
                    child: InkResponse(
                      onTap: () => onDestinationSelected(index),
                      radius: 30,
                      child: SizedBox.expand(
                        child: ExcludeSemantics(
                          child: Center(
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: reduceMotion
                                        ? Duration.zero
                                        : const Duration(milliseconds: 200),
                                    curve: Curves.easeOutCubic,
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selected
                                          ? AppColors.navy
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: selected
                                            ? AppColors.navy
                                            : Colors.transparent,
                                        width: 1.2,
                                      ),
                                    ),
                                    child: IconTheme(
                                      data: IconThemeData(
                                        size: 25,
                                        color: selected
                                            ? Colors.white
                                            : const Color(0xFF9CB3D3),
                                      ),
                                      child: selected
                                          ? destination.selectedIcon ??
                                              destination.icon
                                          : destination.icon,
                                    ),
                                  ),
                                  Positioned(
                                    top: 1,
                                    right: 1,
                                    child: AnimatedOpacity(
                                      opacity: selected ? 1 : 0,
                                      duration: reduceMotion
                                          ? Duration.zero
                                          : const Duration(milliseconds: 200),
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: AppColors.navy,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class WorkspaceHeader extends StatelessWidget {
  const WorkspaceHeader(
      {super.key,
      required this.name,
      required this.workspace,
      required this.icon,
      this.detail,
      this.onNotifications,
      this.onProfile});
  final String name, workspace;
  final String? detail;
  final IconData icon;
  final VoidCallback? onNotifications, onProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.navy, Color(0xFF19588F)]),
          ),
          child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(icon, color: const Color(0xFFAFD4F2), size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(l10n.goodMorning,
                                  style: const TextStyle(
                                      color: Color(0xFFB4CEE5), fontSize: 11)),
                              const SizedBox(height: 3),
                              Text(name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15)),
                            ])),
                        if (onNotifications != null) ...[
                          IconButton.filled(
                              onPressed: onNotifications,
                              tooltip: l10n.navNotifications,
                              style: IconButton.styleFrom(
                                  backgroundColor:
                                      Colors.white.withValues(alpha: .12),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(38, 38),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13))),
                              icon: const Icon(Icons.notifications_outlined,
                                  size: 20)),
                          const SizedBox(width: 8),
                        ],
                        Semantics(
                            label: l10n.navProfile,
                            button: onProfile != null,
                            child: InkWell(
                                onTap: onProfile,
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                    width: 38,
                                    height: 38,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF286594),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                            color: Colors.white70, width: 1.5)),
                                    child: Text(
                                        name
                                            .split(' ')
                                            .where((word) => word.isNotEmpty)
                                            .take(2)
                                            .map((word) => word[0])
                                            .join(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14))))),
                      ]),
                      const SizedBox(height: 12),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF5F9FC),
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(children: [
                            Icon(icon, color: AppColors.navy, size: 19),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Text(detail ?? workspace,
                                    style: const TextStyle(
                                        color: AppColors.navy,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500))),
                          ])),
                      const SizedBox(height: 12),
                      Row(children: [
                        Expanded(
                            flex: 3,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(workspace,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          height: 1.15,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -.3)),
                                  const SizedBox(height: 5),
                                  const Text('N1 TRANSPORTATION',
                                      style: TextStyle(
                                          color: Color(0xFFC7DCEC),
                                          fontSize: 12)),
                                ])),
                        const SizedBox(width: 12),
                        const Flexible(flex: 2, child: CargoArtwork(size: 68)),
                      ]),
                    ]),
              )),
        ),
      );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent(
      {super.key,
      required this.children,
      this.padding = const EdgeInsets.all(AppSpacing.lg)});
  final List<Widget> children;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        children: [
          if (children.isNotEmpty) children.first,
          Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children.skip(1).toList(),
              )),
        ],
      );
}
