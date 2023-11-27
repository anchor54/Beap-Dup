import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/session_key.dart';
import '../../widgets/base_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../utils/hive_utils.dart';
import '../view_model/callendar_screen_vm.dart';

class CalendarScreen extends BaseWidget<CalendarScreenVm> {
  const CalendarScreen({super.key});

  @override
  Widget buildUI(BuildContext context, CalendarScreenVm viewModel) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor:Colors.transparent,
        backgroundColor: context.theme.primary,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: context.theme.onPrimary,
            )),
        title: Text("Calendar",
            style: TextStyle(
                fontSize: 18,
                color: context.theme.onPrimary,
                fontWeight: FontWeight.w700)),
        actions: [],
      ),
      backgroundColor: context.theme.primary,
      body: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        padding: const EdgeInsets.all(8.0),
        child: SfCalendar(
          viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: TextStyle(
                color: context.theme.onSecondary,
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          dataSource: MeetingDataSource(viewModel.getDataSource()),
          monthCellBuilder: monthCellBuilder,
          todayHighlightColor: context.theme.onSecondary,
          headerStyle: CalendarHeaderStyle(
              textStyle: TextStyle(
                  color: context.theme.onPrimary, fontWeight: FontWeight.w400)),
          view: CalendarView.month,
          showNavigationArrow: true,
          monthViewSettings: MonthViewSettings(
            showAgenda: false,
            navigationDirection: MonthNavigationDirection.horizontal,
            dayFormat: 'EEE',
            appointmentDisplayMode: MonthAppointmentDisplayMode.none,
            showTrailingAndLeadingDates: false,
            monthCellStyle: MonthCellStyle(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: MyColor.onPrimary,
                  fontWeight: FontWeight.w400),
              trailingDatesTextStyle: TextStyle(
                  fontSize: 12,
                  color: context.theme.onSecondary,
                  fontWeight: FontWeight.w400),
              leadingDatesTextStyle: TextStyle(
                  fontSize: 12,
                  color: context.theme.onSecondary,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: Platform.isIOS
              ? const EdgeInsets.only(bottom: 30)
              : const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/png/pin.png",
                height: 25,
              ),
              spaceX(),
              Text(
                  "Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: '')}",
                  style: TextStyle(
                      fontSize: 14,
                      color: context.theme.onPrimary,
                      fontWeight: FontWeight.w500))
            ],
          )),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].img;
  }

  @override
  String getStatus(int index) {
    return appointments![index].status;
  }

  @override
  String getDesciption(int index) {
    return appointments![index].description;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.img, this.from, this.to, this.background, this.isAllDay);

  String img;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
  var length = details.appointments.length;
  if (details.appointments.isNotEmpty) {
    Meeting meeting = details.appointments[0] as Meeting;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Opacity(
            opacity: 1,
            child: Container(
              height: 70,
              padding: meeting.img == null
                  ? EdgeInsets.all(0)
                  : const EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
              child: CachedNetworkImage(
                imageUrl: "${meeting.img}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                    height: 10,
                    width: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: context.theme.onPrimary,
                        strokeWidth: 2.0,
                      ),
                    )),
                errorWidget: (context, url, error) => Container(),
              ),
            ),
          ),
        ),
        Text(
          details.date.day.toString(),
          style: TextStyle(
              color: context.theme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
      ],
    );
  }
  return Center(
    child: Text(
      details.date.day.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
          color: context.theme.onPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 18.0),
    ),
  );
}
