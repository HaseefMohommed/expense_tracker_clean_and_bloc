import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalenderPicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  final String? errorText;

  const TableCalenderPicker({
    super.key,
    required this.onDateSelected,
    this.errorText,
  });

  @override
  State<TableCalenderPicker> createState() => _TableCalenderPickerState();
}

class _TableCalenderPickerState extends State<TableCalenderPicker> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.primaryPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.secondaryColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              widget.onDateSelected(selectedDay);
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: SvgPicture.asset(
                AssetsPaths.nextArrow,
              ),
              rightChevronIcon: SvgPicture.asset(
                AssetsPaths.previousArrow,
              ),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryColor,
                  width: 1,
                ),
              ),
              todayTextStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding:
                const EdgeInsets.only(left: AppTheme.primaryPadding, top: 8),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                color: AppTheme.errorColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
