import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg_flutter.dart';

class DatePickerDialogBox extends StatefulWidget {
  final String title;
  final ValueChanged<DateTime> onDateSelected;
  final String? errorText;

  const DatePickerDialogBox({
    super.key,
    required this.title,
    required this.onDateSelected,
    this.errorText,
  });

  @override
  State<DatePickerDialogBox> createState() => _DatePickerDialogBoxState();
}

class _DatePickerDialogBoxState extends State<DatePickerDialogBox> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppTheme.primaryColor,
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryColor,
            ),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: AppTheme.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.errorText != null ? Colors.red : AppTheme.buttonBorderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                      : 'Select a date',
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
                SvgPicture.asset(AssetsPaths.calender),
              ],
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 8),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                color: AppTheme.errorColor,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}