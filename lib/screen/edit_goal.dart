import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/constants/Toasty.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/screen/edit_repeat.dart';
import 'package:jpshua/screen/forgot_password.dart';
import 'package:jpshua/screen/repeat.dart';
import 'package:jpshua/utils/constants.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/edit_goal_vm.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../model/goal_summary_model.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../view_model/create_or_edit_goal_vm.dart';
import '../widgets/base_widget.dart';
import 'package:jpshua/utils/validator.dart';
import 'join_habit.dart';

class EditGoal extends BaseWidget<EditGoalVM> {
  List<Goalinvites> friends = [];

  EditGoal({super.key, required this.friends});

  @override
  Widget buildUI(BuildContext context, EditGoalVM viewModel) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.theme.primary,
      appBar: AppBar(
          backgroundColor: context.theme.primary,
          elevation: 0,
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                viewModel.goTo();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 18, right: 15),
                child: Text("Done",
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColor.themeBlue,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
          title: Text("Details",
              style: TextStyle(
                  fontSize: 15,
                  color: context.theme.onPrimary,
                  fontWeight: FontWeight.w500)),
          leading: InkWell(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: context.theme.onPrimary,
              ))),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
            child: Align(
              child: Form(
                key: viewModel.editDetail,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: viewModel.titleController,
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColor.onSecondary,
                          fontWeight: FontWeight.w400),
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        LengthLimitingTextInputFormatter(16),
                        FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                      ],
                      validator: (value) {
                        return Validator.validateFormField(
                            value!,
                            strErrorTitle,
                            strErrorInvalidUserName,
                            Constants.NORMAL_VALIDATION);
                      },
                      textAlign: TextAlign.start,
                      cursorColor: context.theme.onPrimary,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 10, left: 10),
                          hintText: 'Title',
                          fillColor: MyColor.greyBack,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: MyColor.greyBack),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: MyColor.greyBack),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: MyColor.greyBack),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: MyColor.onSecondary,
                              fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: viewModel.skinController,
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColor.onSecondary,
                          fontWeight: FontWeight.w400),
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      cursorColor: context.theme.onPrimary,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 10, left: 10),
                          hintText: 'Skin in the Game',
                          fillColor: MyColor.greyBack,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: MyColor.greyBack),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: MyColor.greyBack),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: MyColor.greyBack),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: MyColor.onSecondary,
                              fontWeight: FontWeight.w400)),
                    ),
                    spaceY(extra: 20),
                    Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Container(
                                        height: 30,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          color: MyColor.error,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Center(
                                              child: Icon(Icons
                                                  .calendar_month_outlined)),
                                        )),
                                    spaceX(extra: 2),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Date",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: context.theme.onPrimary,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        Visibility(
                                          visible:
                                              viewModel.isSwitchedDate == true
                                                  ? true
                                                  : true,
                                          child: Text(
                                              viewModel.showDate.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: MyColor.themeBlue,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: FlutterSwitch(
                                  height: 30,
                                  width: 60,
                                  value: viewModel.isSwitchedDate,
                                  onToggle: viewModel.toggleSwitchDate,
                                  activeToggleColor: context.theme.primary,
                                  inactiveToggleColor: context.theme.primary,
                                  activeColor: MyColor.green,
                                  inactiveColor: MyColor.greyCircle,
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    Visibility(
                      visible: viewModel.isSwitchedDate == true ? true : false,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SfCalendar(
                            initialSelectedDate: DateFormat('yyyy-MM-dd')
                                .parse(viewModel.date.toString()),
                            initialDisplayDate: DateFormat('yyyy-MM-dd')
                                .parse(viewModel.date.toString()),
                            controller: viewModel.controller,
                            onTap: (CalendarTapDetails details) {},
                            onSelectionChanged:
                                (CalendarSelectionDetails details) {
                              viewModel.dateS(details.date);
                              viewModel.date = DateFormat('yyyy-MM-dd')
                                  .format(details.date!)
                                  .toString();
                              print("------date--${viewModel.date}");
                              String tommDate = DateFormat("yyyy-MM-dd")
                                  .format(viewModel.tommrowDate);
                              if (tommDate == viewModel.date) {
                                viewModel.showDate = "Tomorrow";
                                print("------Tomorrow--${viewModel.showDate}");
                              }
                            },
                            viewHeaderStyle: ViewHeaderStyle(
                              dayTextStyle: TextStyle(
                                  color: context.theme.onSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            headerStyle: CalendarHeaderStyle(
                                textStyle: TextStyle(
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w700)),
                            view: CalendarView.month,
                            todayTextStyle: TextStyle(
                                color: context.theme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            todayHighlightColor: MyColor.onSecondary,
                            showNavigationArrow: true,
                            // selectionDecoration: BoxDecoration(
                            //   color: Colors.transparent,
                            //   border: Border.all(color:MyColor.themeBlue, width: 2),
                            //   borderRadius: const BorderRadius.all(Radius.circular(10)),
                            //   shape: BoxShape.circle,
                            // ),
                            monthViewSettings: MonthViewSettings(
                              showAgenda: false,
                              navigationDirection:
                                  MonthNavigationDirection.horizontal,
                              dayFormat: 'EEE',
                              appointmentDisplayMode:
                                  MonthAppointmentDisplayMode.none,
                              showTrailingAndLeadingDates: false,
                              monthCellStyle: MonthCellStyle(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500),
                                todayTextStyle: TextStyle(
                                  fontSize: 14,
                                  color: context.theme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Container(
                                        height: 30,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          color: MyColor.themeBlue,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Center(
                                              child: Icon(Icons
                                                  .access_time_filled_rounded)),
                                        )),
                                    spaceX(extra: 2),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Time",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: context.theme.onPrimary,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        Visibility(
                                          visible:
                                              viewModel.isSwitchedTime == true
                                                  ? true
                                                  : true,
                                          child: Text(
                                              DateFormat.jm()
                                                  .format(viewModel.dateTime),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: MyColor.themeBlue,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: FlutterSwitch(
                                  height: 30,
                                  width: 60,
                                  value: viewModel.isSwitchedTime,
                                  onToggle: viewModel.toggleSwitchTime,
                                  activeToggleColor: context.theme.primary,
                                  inactiveToggleColor: context.theme.primary,
                                  activeColor: MyColor.green,
                                  inactiveColor: MyColor.greyCircle,
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    Visibility(
                      visible: viewModel.isSwitchedTime == true ? true : false,
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: TextStyle(
                                color: context.theme.onPrimary,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          child: CupertinoDatePicker(
                              initialDateTime: viewModel.dateTime,
                              mode: CupertinoDatePickerMode.time,
                              onDateTimeChanged: (val) {
                                viewModel.timeFunction(val);
                              }),
                        ),
                        // TimePickerSpinner(
                        //   time:viewModel.dateTime,
                        //     is24HourMode: false,
                        //     normalTextStyle: TextStyle(
                        //       color:context.theme.onSecondary,
                        //       fontSize: 14,
                        //     ),
                        //     highlightedTextStyle: TextStyle(
                        //       fontSize: 14,
                        //       color:context.theme.onPrimary,
                        //     ),
                        //     spacing:20,
                        //     itemHeight:50,
                        //     isForce2Digits: true,
                        //     onTimeChange:viewModel.timeFunction
                        // ),
                      ),
                    ),
                    spaceY(extra: 20),
                    Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              context.push(EditRepeat());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 30,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            color: MyColor.onSecondary,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Center(
                                                child:
                                                    Icon(Icons.repeat_rounded)),
                                          )),
                                      spaceX(extra: 2),
                                      Text("Repeat",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: context.theme.onPrimary,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Text(viewModel.addRepeat.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    context.theme.onSecondary,
                                                fontWeight: FontWeight.w500)),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: context.theme.onPrimary,
                                          size: 20,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        )),
                    spaceY(extra: 30),
                    Text("Friends",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: context.theme.onPrimary,
                            fontWeight: FontWeight.w500)),
                    spaceY(extra: 5),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: friends.length,
                            primary: true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                width: 50,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: friends[index].user![0].image !=
                                          "null"
                                      ? "$baseUrl${friends[index].user![0].image}"
                                      : "",
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 50,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) => CircleAvatar(
                                    radius: 50,
                                    backgroundColor: MyColor.blue,
                                    child: Text(
                                      friends[index]
                                          .user![0]
                                          .name
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: context.theme.primary,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    radius: 50,
                                    backgroundColor: MyColor.blue,
                                    child: Text(
                                      friends[index]
                                          .user![0]
                                          .name
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: context.theme.primary,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return spaceX();
                            },
                          ),
                          CircleAvatar(
                            radius: 23,
                            backgroundColor: MyColor.greyCircle,
                            child: IconButton(
                              onPressed: () {
                                // HiveUtils.addSession(SessionKey.habitName, viewModel.goalSummaryModel.activity!.habitTitle.toString());
                                context.push(const JoinHabit());
                              },
                              icon: Icon(
                                Icons.add,
                                color: context.theme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      )),
    );
  }
}
