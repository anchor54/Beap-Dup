import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/repeat.dart';
import 'package:jpshua/screen/select_friends_screen.dart';
import 'package:jpshua/utils/constants.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/widgets/atom/actionable_container.dart';
import 'package:jpshua/widgets/atom/calender_widget.dart';
import 'package:jpshua/widgets/atom/icon_title_subtitle.dart';
import 'package:jpshua/widgets/post_visibility_bottomsheet.dart';
import 'package:jpshua/widgets/time_picker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../utils/appStrings.dart';
import '../view_model/create_or_edit_goal_vm.dart';
import '../widgets/base_widget.dart';
import 'package:jpshua/utils/validator.dart';

class CreateOrEditGoal extends BaseWidget<CreateOrEditGoalVM> {
  final String? activityId;
  const CreateOrEditGoal({super.key, this.activityId});

  @override
  void beforeInitState(BuildContext context, CreateOrEditGoalVM viewModel) {
    viewModel.activityId = activityId;
  }

  @override
  Widget buildUI(BuildContext context, CreateOrEditGoalVM viewModel) {
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
                if (activityId == null) {
                  viewModel.addActivity();
                } else {
                  viewModel.editActivity();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                  ),
                ),
              ),
            ),
          ],
          title: Text(
            '${viewModel.activityId == null ? "Create" : "Edit"} Goal',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.02,
            ),
          ),
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
                key: viewModel.detail,
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
                          contentPadding: const EdgeInsets.all(14),
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
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    spaceY(extra: 1),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: viewModel.skinController,
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColor.onSecondary,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                      cursorColor: context.theme.onPrimary,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(14),
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
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    spaceY(extra: 20),
                    ActionableContainer(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitleSubtitle(
                              title: 'Date',
                              subtitle: viewModel.isSwitchedDate
                                  ? viewModel.showDate
                                  : null,
                              icon: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    // color: MyColor.error,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Image.asset('assets/svg/date.png')),
                              seperation: 11.0,
                            ),
                            FlutterSwitch(
                              height: 33,
                              width: 65,
                              toggleSize: 30,
                              padding: 1,
                              value: viewModel.isSwitchedDate,
                              onToggle: viewModel.toggleSwitchDate,
                              activeToggleColor: context.theme.primary,
                              inactiveToggleColor: context.theme.primary,
                              activeColor: MyColor.green,
                              inactiveColor: MyColor.greyCircle,
                            )
                          ],
                        )),
                    spaceY(extra: 1),
                    Visibility(
                      visible: viewModel.isSwitchedDate == true ? true : false,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                        child: CalendarWidget(
                          controller: viewModel.controller,
                          onDateChanged: (CalendarSelectionDetails details) {
                            viewModel.dateS(details.date);
                          },
                        ),
                      ),
                    ),
                    spaceY(extra: 1),
                    ActionableContainer(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              viewModel.isSwitchedTime ? 0 : 10),
                          bottomRight: Radius.circular(
                              viewModel.isSwitchedTime ? 0 : 10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitleSubtitle(
                              title: 'Time',
                              subtitle: viewModel.isSwitchedTime
                                  ? DateFormat('hh:mm a')
                                      .format(viewModel.dateTime)
                                  : null,
                              icon: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFF0B8CE9),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Image.asset('assets/svg/time.png')),
                              seperation: 11.0,
                            ),
                            FlutterSwitch(
                              height: 33,
                              width: 65,
                              toggleSize: 30,
                              padding: 1,
                              value: viewModel.isSwitchedTime,
                              onToggle: viewModel.toggleSwitchTime,
                              activeToggleColor: context.theme.primary,
                              inactiveToggleColor: context.theme.primary,
                              activeColor: MyColor.green,
                              inactiveColor: MyColor.greyCircle,
                            ),
                          ],
                        )),
                    spaceY(extra: 2),
                    Visibility(
                      visible: viewModel.isSwitchedTime,
                      child: ActionableContainer(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: TimePicker(
                          initialDateTime: viewModel.dateTime,
                          onDateTimeChanged: (val) {
                            viewModel.timeFunction(val);
                          },
                        ),
                      ),
                    ),
                    spaceY(extra: 20),
                    ActionableContainer(
                        onTap: () {
                          context.push(Repeat());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitleSubtitle(
                              title: "Repeat",
                              icon: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFF656469),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Image.asset('assets/svg/repeat.png')),
                              seperation: 11.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  viewModel.addRepeat,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFF797979),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: context.theme.onPrimary,
                                  size: 16,
                                ),
                              ],
                            )
                          ],
                        )),
                    spaceY(extra: 30),
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
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Text(viewModel.postVisibility.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: context.theme.onSecondary,
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
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: MyColor.primary,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              builder: (BuildContext context) {
                                return PostVisibilityBottomSheet(
                                  visibility: viewModel.postVisibility,
                                  onVisibilitySelected: (PostVisibility value) {
                                    if (value == PostVisibility.PARTIAL) {
                                      Navigator.of(context).pop();
                                      return Future.delayed(
                                          Duration(milliseconds: 100), () {
                                        _showChooseFriendsBottomSheet(
                                            context, viewModel, value);
                                      });
                                    }
                                    viewModel.postVisibility = value;
                                    Navigator.of(context).pop();
                                  },
                                );
                              });
                        }),
                  ],
                ),
              ),
            )),
      )),
    );
  }

  void _showChooseFriendsBottomSheet(BuildContext context,
      CreateOrEditGoalVM viewModel, PostVisibility value) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.95,
            maxChildSize: 0.95,
            minChildSize: 0.4,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return SelectFriendsScreen(
                followers: viewModel.followers,
                selectedFollowers: viewModel.postVisibleTo,
                onFriendsSelected: (friends) {
                  if (friends.isNotEmpty) {
                    viewModel.postVisibleTo = friends;
                    viewModel.postVisibility = value;
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
