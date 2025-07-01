import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import '../app_theme.dart';
import '../gradients.dart';
import '../styles.dart';
import 'svg_icon.dart';

class DatePickerSpinner extends StatefulWidget {
  final String? selectedDate;
  final Function(String) onDateSelected;

  const DatePickerSpinner({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DatePickerSpinner> createState() => _DatePickerSpinnerState();
}

class _DatePickerSpinnerState extends State<DatePickerSpinner> {
  bool _isExpanded = false;
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  void didUpdateWidget(DatePickerSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      setState(() {
        _selectedDate = widget.selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: spinnerGradient,
              borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FigmaHelper.px(context, 45),
                vertical: FigmaHelper.px(context, 34),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate ?? 'Select Date...',
                      style: AppTypography.spinnerTitle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomSvgIcon(
                    assetPath: 'assets/icons/triangle_arrow_down.svg',
                    size: FigmaHelper.iconSize(context, 29),
                    color: AppTheme.white,
                    isSelected: true,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: FigmaHelper.px(context, 8)),
            decoration: BoxDecoration(
              gradient: spinnerGradient,
              borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
            ),
            child: Padding(
              padding: EdgeInsets.all(FigmaHelper.px(context, 16)),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single,
                  selectedDayHighlightColor: AppTheme.accentOrange,
                  dayTextStyle: TextStyle(
                    color: AppTheme.white,
                    fontSize: FigmaHelper.px(context, 16),
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w600,
                  ),
                  selectedDayTextStyle: TextStyle(
                    color: AppTheme.white,
                    fontSize: FigmaHelper.px(context, 16),
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w700,
                  ),
                  todayTextStyle: TextStyle(
                    color: AppTheme.darkBlue,
                    fontSize: FigmaHelper.px(context, 16),
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w700,
                  ),
                  monthTextStyle: TextStyle(
                    color: AppTheme.white,
                    fontSize: FigmaHelper.px(context, 18),
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w700,
                  ),
                  yearTextStyle: TextStyle(
                    color: AppTheme.white,
                    fontSize: FigmaHelper.px(context, 18),
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w700,
                  ),
                  controlsTextStyle: TextStyle(
                    color: AppTheme.white,
                    fontSize: FigmaHelper.px(context, 16),
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w600,
                  ),
                  dayBorderRadius: BorderRadius.circular(FigmaHelper.px(context, 8)),
                ),
                value: _selectedDate != null ? [_parseDate(_selectedDate!)] : [],
                onValueChanged: (dates) {
                  if (dates.isNotEmpty && dates.first != null) {
                    final date = dates.first;
                    final formattedDate = _formatDate(date);
                    setState(() {
                      _selectedDate = formattedDate;
                      _isExpanded = false;
                    });
                    widget.onDateSelected(formattedDate);
                  }
                },
              ),
            ),
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day.$month.$year';
  }

  DateTime _parseDate(String dateString) {
    final parts = dateString.split('.');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
} 