import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  final CalendarController? controller;
  final Function(CalendarSelectionDetails details)? onDateChanged;

  CalendarWidget({super.key, required this.controller, this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 25.0),
      child: SfCalendar(
        controller: controller ?? CalendarController(),
        onTap: (CalendarTapDetails details) {},
        onSelectionChanged: onDateChanged,
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(
              color: context.theme.onSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        headerStyle: CalendarHeaderStyle(
            textStyle: TextStyle(
                color: context.theme.onPrimary, fontWeight: FontWeight.w700)),
        view: CalendarView.month,
        todayTextStyle: TextStyle(
            color: context.theme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w500),
        todayHighlightColor: MyColor.themeBlue,
        showNavigationArrow: true,
        monthViewSettings: MonthViewSettings(
          showAgenda: false,
          navigationDirection: MonthNavigationDirection.horizontal,
          dayFormat: 'EEE',
          appointmentDisplayMode: MonthAppointmentDisplayMode.none,
          showTrailingAndLeadingDates: false,
          monthCellStyle: MonthCellStyle(
            textStyle: TextStyle(
                fontSize: 20,
                color: context.theme.onPrimary,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
