import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/screen/calendar_view.dart';
import 'package:jpshua/screen/create_or_edit_goal.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/widgets/atom/actionable_container.dart';
import 'package:jpshua/widgets/atom/icon_title_subtitle.dart';
import '../constants/my_theme.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../view_model/past_goal_summay_vm.dart';
import '../widgets/base_widget.dart';

class GoalSummary extends BaseWidget<GoalSummaryVM> {
  const GoalSummary({super.key, required this.title, this.editable = true});
  final String title;
  final bool editable;

  @override
  Widget buildUI(BuildContext context, GoalSummaryVM viewModel) {
    return FocusDetector(
      onFocusGained: () {
        viewModel.getPostSummary();
      },
      child: Scaffold(
        appBar: AppBar(
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
          title: Text(title,
              style: TextStyle(
                  fontSize: 18,
                  color: context.theme.onPrimary,
                  fontWeight: FontWeight.w700)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: editable
                  ? InkWell(
                      onTap: () {
                        HiveUtils.addSession(
                            SessionKey.habitName,
                            viewModel.goalSummaryModel?.activity!.habitTitle
                                .toString());
                        HiveUtils.addSession(
                            SessionKey.skin,
                            viewModel.goalSummaryModel?.activity!.skinGame
                                .toString());
                        HiveUtils.addSession(
                            SessionKey.repeat,
                            viewModel.goalSummaryModel?.activity!.repeat!.type
                                .toString());
                        HiveUtils.addSession(
                            SessionKey.time,
                            viewModel.goalSummaryModel?.activity!.everyDayAt!
                                .toString());
                        HiveUtils.addSession(
                            SessionKey.startDate,
                            viewModel.goalSummaryModel?.activity!.startDate!
                                .toString());
                        HiveUtils.addSession(
                            SessionKey.editFreq,
                            viewModel
                                .goalSummaryModel?.activity!.repeat!.frequency
                                .toString());
                        HiveUtils.addSession(
                            SessionKey.editEveryType,
                            viewModel
                                .goalSummaryModel?.activity!.repeat!.every!.type
                                .toString());
                        HiveUtils.addSession(
                            SessionKey.editEveryFre,
                            viewModel.goalSummaryModel?.activity!.repeat!.every!
                                .frequency
                                .toString());
                        HiveUtils.addSession(SessionKey.selectedWeek,
                            viewModel.goalSummaryModel?.activity!.repeat!.days);
                        HiveUtils.addSession(
                            SessionKey.activityId,
                            viewModel.goalSummaryModel?.activity!.sId
                                .toString());
                        HiveUtils.addSession(SessionKey.goalId,
                            viewModel.goalSummaryModel?.activity!.sId);
                        context.push(CreateOrEditGoal(
                          activityId: HiveUtils.getSession<String?>(
                              SessionKey.activityId,
                              defaultValue: null),
                        ));
                      },
                      child: Text("Edit",
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color(0xFF808080),
                              fontWeight: FontWeight.w500)),
                    )
                  : null,
            ),
          ],
        ),
        extendBody: true,
        backgroundColor: context.theme.primary,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ActionableContainer(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                          viewModel.goalSummaryModel?.activity?.habitTitle ??
                              '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              color: context.theme.onPrimary,
                              fontWeight: FontWeight.w400)),
                    )),
                spaceY(extra: 1),
                ActionableContainer(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                          viewModel.goalSummaryModel?.activity?.skinGame ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              color: context.theme.onPrimary,
                              fontWeight: FontWeight.w400)),
                    )),
                spaceY(extra: 10),
                ActionableContainer(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconTitleSubtitle(
                                title: 'Start Date',
                                icon: Container(
                                    // padding: const EdgeInsets.all(6),
                                    // decoration: BoxDecoration(
                                    //   color: MyColor.error,
                                    //   borderRadius: BorderRadius.circular(6),
                                    // ),
                                    child: Image.asset('assets/svg/date.png')),
                                seperation: 10.0,
                              ),
                              Text(
                                  DateFormat("EEEE, MMMM dd, yyyy").format(
                                      DateFormat("yyyy-MM-dd").parse(viewModel
                                              .goalSummaryModel
                                              ?.activity
                                              ?.startDate ??
                                          '')),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          spaceY(extra: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconTitleSubtitle(
                                title: 'Time',
                                icon: Container(
                                    // padding: const EdgeInsets.all(6),
                                    // decoration: BoxDecoration(
                                    //   color: const Color(0xFF0A84F8),
                                    //   borderRadius: BorderRadius.circular(6),
                                    // ),
                                    child: Image.asset('assets/svg/time.png')),
                                seperation: 10.0,
                              ),
                              Text(
                                  viewModel.goalSummaryModel?.activity
                                          ?.everyDayAt ??
                                      '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                    )),
                spaceY(extra: 20),
                Container(
                    decoration: BoxDecoration(
                      color: MyColor.greyBack,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitleSubtitle(
                              title: 'Repeat',
                              icon: Container(
                                  // padding: const EdgeInsets.all(6),
                                  // decoration: BoxDecoration(
                                  //   color: const Color(0xFF646569),
                                  //   borderRadius: BorderRadius.circular(6),
                                  // ),
                                  child: Image.asset('assets/svg/repeat.png')),
                              seperation: 10.0,
                            ),
                            Text(
                                viewModel.goalSummaryModel?.activity!.repeat!
                                        .type ??
                                    '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    )),
                spaceY(extra: 20),
                ActionableContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconTitleSubtitle(
                          title: 'View',
                          icon: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(
                                "assets/svg/fa-solid_user-friends.svg"),
                          ),
                          seperation: 10.0,
                        ),
                        Text(
                            viewModel.goalSummaryModel?.activity!.postVisibility
                                    ?.title ??
                                '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: context.theme.onPrimary,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    onTap: () {}),
                spaceY(extra: 30),
                Text(
                  "Your Journey",
                  style: TextStyle(
                    fontSize: 16,
                    color: context.theme.onPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                spaceY(extra: 10),
                SizedBox(
                  height: 70,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount:
                        viewModel.goalSummaryModel?.currentWeekArray?.length ??
                            0,
                    primary: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: DateFormat("yyyy-MM-dd").parse(viewModel.goalSummaryModel?.activity!.startDate ?? '') ==
                                    DateFormat("yyyy-MM-dd").parse(viewModel
                                            .goalSummaryModel
                                            ?.currentWeekArray?[index]
                                            .dayDate ??
                                        '') ||
                                DateFormat("yyyy-MM-dd")
                                    .parse(viewModel.goalSummaryModel?.activity!.startDate ??
                                        '')
                                    .isBefore(DateFormat("yyyy-MM-dd").parse(viewModel
                                            .goalSummaryModel
                                            ?.currentWeekArray?[index]
                                            .dayDate ??
                                        ''))
                            ? true
                            : false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.goalSummaryModel
                                      ?.currentWeekArray?[index].dayName
                                      ?.toUpperCase() ??
                                  '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: context.theme.onSecondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.0),
                            ),
                            spaceY(),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                viewModel.goalSummaryModel
                                            ?.currentWeekArray![index].dailyPost
                                            .toString() !=
                                        "null"
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Opacity(
                                          opacity: 0.9,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${viewModel.goalSummaryModel?.currentWeekArray![index].dailyPost!.image}",
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                SizedBox(
                                                    height: 10,
                                                    width: 10,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: context
                                                            .theme.onPrimary,
                                                        strokeWidth: 2.0,
                                                      ),
                                                    )),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                      ),
                                Center(
                                  child: Text(
                                    DateFormat.d().format(
                                        DateFormat("yyyy-MM-dd").parse(viewModel
                                                .goalSummaryModel
                                                ?.currentWeekArray?[index]
                                                .dayDate ??
                                            '')),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: viewModel
                                                    .goalSummaryModel
                                                    ?.currentWeekArray?[index]
                                                    .dailyPost
                                                    .toString() !=
                                                "null"
                                            ? context.theme.primary
                                            : context.theme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return spaceX();
                    },
                  ),
                ),
                spaceY(extra: 10),
                Center(
                  child: InkWell(
                    onTap: () {
                      // HiveUtils.addSession(SessionKey.activityId,viewModel.goalSummaryModel.sId.toString());
                      context.push(const CalendarScreen());
                    },
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("View Full Calender",
                              style: TextStyle(
                                fontSize: 14,
                                color: context.theme.onSecondary,
                              )),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: context.theme.onSecondary,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
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
                    "Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}",
                    style: TextStyle(
                        fontSize: 14,
                        color: context.theme.onPrimary,
                        fontWeight: FontWeight.w500))
              ],
            )),
      ),
    );
  }
}
