import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/edit_custom_vm.dart';
import 'package:jpshua/view_model/edit_repeat.dart';
import 'package:jpshua/view_model/past_goal_summay_vm.dart';
import 'package:jpshua/view_model/profile_vm.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../constants/Toasty.dart';
import '../model/sent_request_model.dart';
import '../utils/hive_utils.dart';
import 'home_vm.dart';

class EditGoalVM extends BaseViewModel {
  String addRepeat = "";
  get addRepeats => addRepeat;

  set addRepeats(value) {
    addRepeat = value;
    notifyListeners();
  }

  final CalendarController controller = CalendarController();
  DateTime dateTime = DateTime.now();
  // DateTime currentdateTime = DateTime.now();
  int num = HiveUtils.getSession(SessionKey.goalCount);
  bool isSwitchedDate = false;
  bool isSwitchedTime = false;
  bool _isNoFriend = false;
  String date = "";
  String showDate = "";
  late DateTime tommrowDate;
  late DateTime ex;
  late EditRepeatVM repeatVm;
  late EditCustomVM customVm;
  late GoalSummaryVM goalSummaryVm;
  late ProfileVM profileVm;
  late HomeVM homeVm;
  var titleController = TextEditingController();
  var skinController = TextEditingController();
  GlobalKey<FormState> editDetail = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }

  updateFun(value) {
    addRepeat = value;
    notifyListeners();
  }

  void toggleSwitchDate(bool value) {
    if (isSwitchedDate == false) {
      isSwitchedDate = true;
      if (showDate.isEmpty) {
        showDate = "Today";
        date = DateFormat('yyyy-MM-dd').format(dateTime);
        notifyListeners();
      }
    } else {
      isSwitchedDate = false;
    }
    notifyListeners();
  }

  void toggleSwitchTime(bool value) {
    if (isSwitchedTime == false) {
      isSwitchedTime = true;
    } else {
      isSwitchedTime = false;
    }
    if (isSwitchedTime == true) {
      isSwitchedDate = false;
    }
    notifyListeners();
  }

  bool get isNoFriend => _isNoFriend;

  set isNoFriend(bool value) {
    _isNoFriend = value;
  }

  void timeFunction(time) {
    dateTime = time;
    notifyListeners();
  }

  DateTime convertTimeStringToDateTime(String timeString) {
    final DateFormat format = DateFormat("h:mm a");
    return format.parse(timeString);
  }

  dateS(selected) {
    if (DateFormat("yyyy-MM-dd").format(dateTime) ==
        DateFormat("yyyy-MM-dd").format(selected)) {
      showDate = "Today";
    } else {
      showDate = DateFormat.yMMMEd().format(selected).toString();
    }
    notifyListeners();
  } // Your time string

  @override
  initView() {
    dateTime = convertTimeStringToDateTime(
        HiveUtils.getSession<String>(SessionKey.time, defaultValue: ""));
    print("---------edit time------${dateTime}");
    repeatVm = context.read<EditRepeatVM>();
    customVm = context.read<EditCustomVM>();
    goalSummaryVm = context.read<GoalSummaryVM>();
    homeVm = context.read<HomeVM>();
    profileVm = context.read<ProfileVM>();
    _isNoFriend = false;
    isSwitchedDate = false;
    isSwitchedTime = false;
    titleController.text =
        HiveUtils.getSession<String>(SessionKey.habitName, defaultValue: "");
    skinController.text =
        HiveUtils.getSession<String>(SessionKey.skin, defaultValue: "");
    date = HiveUtils.getSession<String>(SessionKey.startDate, defaultValue: "");
    showDate = DateFormat.yMMMEd()
        .format(DateFormat("yyyy-MM-dd").parse(HiveUtils.getSession<String>(
            SessionKey.startDate,
            defaultValue: "")))
        .toString();
    addRepeat =
        HiveUtils.getSession<String>(SessionKey.repeat, defaultValue: "");
    customVm.frequency =
        HiveUtils.getSession<String>(SessionKey.editFreq, defaultValue: "");
    customVm.every =
        "${HiveUtils.getSession<String>(SessionKey.editEveryType, defaultValue: "").isNotEmpty ? HiveUtils.getSession<String>(SessionKey.editEveryType) : "1"}${" "}${customVm.frequency == "Daily" ? "Day" : customVm.frequency == "Weekly" ? "week" : customVm.frequency == "Monthly" ? "month" : ""}";
    customVm.occur =
        "${HiveUtils.getSession<String>(SessionKey.editEveryType, defaultValue: "").isNotEmpty ? HiveUtils.getSession<String>(SessionKey.editEveryType) : "1"}${" "}${customVm.frequency == "Daily" ? "day" : customVm.frequency == "Weekly" ? "week" : customVm.frequency == "Monthly" ? "month" : ""}";
    customVm.tempOccur =
        "${HiveUtils.getSession<String>(SessionKey.editEveryType, defaultValue: "").isNotEmpty ? HiveUtils.getSession<String>(SessionKey.editEveryType) : "1"}${" "}${customVm.frequency == "Daily" ? "day" : customVm.frequency == "Weekly" ? "week" : customVm.frequency == "Monthly" ? "month" : ""}";
    customVm.selectedWeek =
        HiveUtils.getSession<List>(SessionKey.selectedWeek, defaultValue: []);
    tommrowDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day + 1,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
    );
    return super.initView();
  }

  @override
  disposeView() {
    return super.disposeView();
  }

  void goTo() {
    if (editDetail.currentState!.validate()) {
      callMap(
          path: "Activity/updateActivity",
          onSuccess: (statusCode, data) {
            Map object = jsonDecode(data);
            // Toasty.showtoast(object['message']);
            HiveUtils.addSession(SessionKey.habitName,
                object['result']['habitTitle'].toString());
            HiveUtils.addSession(
                SessionKey.goalId, object['result']['_id'].toString());
            int value = num + 1;
            HiveUtils.addSession(SessionKey.goalCount, value);
            goalSummaryVm.getPostSummary();
            profileVm.getActiveGoal("activeGoal");
            homeVm.getGoal();
            context.pop();
          },
          isShowLoader: false,
          method: Method.put,
          params: {
            "_id": HiveUtils.getSession<String>(SessionKey.activityId,
                defaultValue: ""),
            "habitTitle": titleController.text.toString(),
            "skinGame": skinController.text,
            "startDate": date,
            "everyDayAt": DateFormat.jm().format(dateTime),
            "utceveryDayAt": DateFormat.jm().format(dateTime.toUtc()),
            "repeat": {
              "type": addRepeat.toString(),
              "frequency": customVm.frequency.toString(),
              "every": {
                "type": HiveUtils.getSession<String>(SessionKey.editEveryType,
                    defaultValue: ""),
                "frequency": HiveUtils.getSession<String>(
                    SessionKey.editEveryFre,
                    defaultValue: "")
              },
              "days": customVm.selectedWeek
            }
          });
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }
}
