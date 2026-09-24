import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

List<String> reportMonthNames(AppLocalizations l10n) => [
      l10n.monthJan,
      l10n.monthFeb,
      l10n.monthMar,
      l10n.monthApr,
      l10n.monthMay,
      l10n.monthJun,
      l10n.monthJul,
      l10n.monthAug,
      l10n.monthSep,
      l10n.monthOct,
      l10n.monthNov,
      l10n.monthDec,
    ];

String formatReportDate(BuildContext context, DateTime date) {
  final now = DateTime.now();
  final time = TimeOfDay.fromDateTime(date).format(context);
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today · $time';
  }
  final months = reportMonthNames(AppLocalizations.of(context)!);
  return '${months[date.month - 1]} ${date.day} · $time';
}

/// A row of Day / Month / Year dropdown filters for narrowing a dated list.
class DateFilterBar extends StatelessWidget {
  const DateFilterBar({
    super.key,
    required this.day,
    required this.month,
    required this.year,
    required this.availableYears,
    required this.onDayChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
  });
  final int? day, month, year;
  final List<int> availableYears;
  final ValueChanged<int?> onDayChanged, onMonthChanged, onYearChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final months = reportMonthNames(l10n);
    return Row(
      children: [
        Expanded(
          child: _FilterDropdown<int>(
            label: l10n.filterDay,
            value: day,
            allLabel: l10n.filterAll,
            items: [
              for (var d = 1; d <= 31; d++) (value: d, label: '$d'),
            ],
            onChanged: onDayChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilterDropdown<int>(
            label: l10n.filterMonth,
            value: month,
            allLabel: l10n.filterAll,
            items: [
              for (var m = 1; m <= 12; m++) (value: m, label: months[m - 1]),
            ],
            onChanged: onMonthChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilterDropdown<int>(
            label: l10n.filterYear,
            value: year,
            allLabel: l10n.filterAll,
            items: [
              for (final y in availableYears) (value: y, label: '$y'),
            ],
            onChanged: onYearChanged,
          ),
        ),
      ],
    );
  }
}

/// Returns true when [date] matches the selected day/month/year, treating a
/// null selection as "any".
bool matchesDateFilter(DateTime date, {int? day, int? month, int? year}) {
  if (day != null && date.day != day) return false;
  if (month != null && date.month != month) return false;
  if (year != null && date.year != year) return false;
  return true;
}

class _FilterDropdown<T> extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.allLabel,
    required this.items,
    required this.onChanged,
  });
  final String label;
  final T? value;
  final String allLabel;
  final List<({T value, String label})> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T?>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        items: [
          DropdownMenuItem<T?>(value: null, child: Text(allLabel)),
          for (final item in items)
            DropdownMenuItem<T?>(value: item.value, child: Text(item.label)),
        ],
        onChanged: onChanged,
      );
}
