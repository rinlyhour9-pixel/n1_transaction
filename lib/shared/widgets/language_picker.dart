import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

Future<void> showLanguagePicker(
  BuildContext context,
  Locale current,
  ValueChanged<Locale> onChanged,
) async {
  final l10n = AppLocalizations.of(context)!;
  final selected = await showDialog<Locale>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.selectLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Each option is always shown in its own native script, not
          // translated into whichever language is currently active — that
          // is how a user finds their language even if they can't read
          // the current UI language.
          RadioListTile<Locale>(
            value: const Locale('en'),
            groupValue: current,
            title: const Text('English'),
            onChanged: (value) => Navigator.pop(context, value),
          ),
          RadioListTile<Locale>(
            value: const Locale('km'),
            groupValue: current,
            title: const Text('ខ្មែរ'),
            onChanged: (value) => Navigator.pop(context, value),
          ),
        ],
      ),
    ),
  );
  if (selected != null) onChanged(selected);
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

  @override
  Widget build(BuildContext context) => Material(
        color: light ? Colors.white.withValues(alpha: .16) : Colors.black.withValues(alpha: .06),
        shape: const StadiumBorder(),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () => showLanguagePicker(context, locale, onLocaleChanged),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.language,
                    size: 18, color: light ? Colors.white : null),
                const SizedBox(width: 6),
                Text(
                  locale.languageCode == 'km' ? 'ខ្មែរ' : 'English',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: light ? Colors.white : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
