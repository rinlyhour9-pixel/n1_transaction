import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

const _languages = [
  (
    locale: Locale('en'),
    flagAsset: 'assets/images_Logo/EN_Language.png',
    name: 'English',
    code: 'EN',
  ),
  (
    locale: Locale('km'),
    flagAsset: 'assets/images_Logo/KH_Language.png',
    name: 'ខ្មែរ',
    code: 'KH',
  ),
];

/// Shows the language options as a small popup anchored right under
/// [anchorContext]'s widget, instead of a centered modal dialog.
Future<void> showLanguagePicker(
  BuildContext anchorContext,
  Locale current,
  ValueChanged<Locale> onChanged,
) async {
  final button = anchorContext.findRenderObject() as RenderBox;
  final overlay =
      Overlay.of(anchorContext).context.findRenderObject() as RenderBox;
  final position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset(0, button.size.height + 6),
          ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero),
          ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );

  final selected = await showMenu<Locale>(
    context: anchorContext,
    position: position,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    constraints: const BoxConstraints(minWidth: 168, maxWidth: 168),
    items: [
      // Each option is always shown in its own native script, not
      // translated into whichever language is currently active — that
      // is how a user finds their language even if they can't read
      // the current UI language.
      for (final language in _languages)
        PopupMenuItem<Locale>(
          value: language.locale,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _LanguageOption(
            flagAsset: language.flagAsset,
            name: language.name,
            selected: current.languageCode == language.locale.languageCode,
          ),
        ),
    ],
  );
  if (selected != null) onChanged(selected);
}

/// Renders a flag badge image at an identical fixed size every time.
class _FlagIcon extends StatelessWidget {
  const _FlagIcon(this.asset, {super.key, this.size = 18});
  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) => Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.flagAsset,
    required this.name,
    required this.selected,
  });
  final String flagAsset, name;
  final bool selected;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.navy.withValues(alpha: .1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: _FlagIcon(flagAsset, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(name,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 14)),
          ),
          SizedBox(
            width: 18,
            child: selected
                ? const Icon(Icons.check, size: 18, color: AppColors.navy)
                : null,
          ),
        ],
      );
}

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    this.light = false,
  });
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final bool light;

  static const _knobSize = 34.0;
  static const _trackSize = Size(92, 40);
  static const _duration = Duration(milliseconds: 280);

  @override
  Widget build(BuildContext context) {
    final isKhmer = locale.languageCode == 'km';
    final other = isKhmer ? _languages[0] : _languages[1];
    final track = light
        ? Colors.white.withValues(alpha: .16)
        : Colors.black.withValues(alpha: .05);

    return GestureDetector(
      onTap: () => onLocaleChanged(other.locale),
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeOutCubic,
        width: _trackSize.width,
        height: _trackSize.height,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(color: track, shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(_trackSize.height / 2)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // The code for the language a tap would switch *to* sits at the
            // opposite end from the knob, revealed as it slides away.
            Align(
              alignment:
                  isKhmer ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  other.code,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: .4,
                    color: (light ? Colors.white : AppColors.navy)
                        .withValues(alpha: .55),
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: _duration,
              curve: Curves.easeOutCubic,
              alignment:
                  isKhmer ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: _knobSize,
                height: _knobSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .28),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: _FlagIcon(
                      isKhmer
                          ? _languages[1].flagAsset
                          : _languages[0].flagAsset,
                      key: ValueKey(locale.languageCode),
                      size: _knobSize,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
