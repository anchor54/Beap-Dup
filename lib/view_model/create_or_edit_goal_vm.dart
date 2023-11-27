import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/model/goal_summary_model.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/screen/base_home.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/custom_vm.dart';
import 'package:jpshua/view_model/profile_vm.dart';
import 'package:jpshua/view_model/repeat_vm.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants/Toasty.dart';
import '../model/sent_request_model.dart';
import '../screen/StarEndDate.dart';
import '../utils/hive_utils.dart';
import 'home_vm.dart';

enum PostVisibility {
  PUBLIC(
      title: "Followers",
      name: "Public",
      subtitle: "Visible only to whoever follows your account"),
  PRIVATE(title: "Private", name: "Private", subtitle: "Only you"),
  PARTIAL(
      title: "Custom",
      name: "Partial",
      subtitle: "Visible only to selected friends");

  const PostVisibility(
      {required this.title, required this.name, required this.subtitle});

  final String title;
  final String name;
  final String subtitle;
}

class CreateOrEditGoalVM extends BaseViewModel {
  String addRepeat = "Never";
  String? activityId = null;
  get addRepeats => addRepeat;

  set addRepeats(value) {
    addRepeat = value;
    notifyListeners();
  }

  PostVisibility visibility = PostVisibility.PUBLIC;
  List<UserFollowModel> postVisibleTo = [];
  PostVisibility get postVisibility => visibility;
  set postVisibility(PostVisibility value) {
    visibility = value;
    notifyListeners();
  }

  final CalendarController controller = CalendarController();
  DateTime dateTime = DateTime.now();
  List<SendRequest> friends = [];
  List<UserFollowModel> followers = [];
  bool isSwitchedDate = false;
  bool isSwitchedTime = false;
  bool _isNoFriend = false;
  String date = "";
  String showDate = "";
  late DateTime tommrowDate;
  late RepeatVM repeatVm;
  late CustomVM customVm;
  late HomeVM homeVm;

  var titleController = TextEditingController();
  var skinController = TextEditingController();
  GlobalKey<FormState> detail = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
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
    notifyListeners();
  }

  bool get isNoFriend => _isNoFriend;

  set isNoFriend(bool value) {
    _isNoFriend = value;
  }

  void timeFunction(time) {
    dateTime = time;
    print("-----time-------${dateTime}");
    notifyListeners();
  }

  dateS(selected) {
    controller.selectedDate = selected;
    if (DateFormat("yyyy-MM-dd").format(DateTime.now()) ==
        DateFormat("yyyy-MM-dd").format(selected)) {
      showDate = "Today";
    } else if (DateFormat("yyyy-MM-dd")
            .format(DateTime.now().add(Duration(days: 1))) ==
        DateFormat("yyyy-MM-dd").format(selected)) {
      showDate = "Tomorrow";
    } else {
      showDate = DateFormat("dd/MM/yyyy").format(selected);
    }
    notifyListeners();
  }

  @override
  initView() {
    _isNoFriend = false;
    isSwitchedDate = false;
    isSwitchedTime = false;
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
    repeatVm = context.read<RepeatVM>();
    customVm = context.read<CustomVM>();
    homeVm = context.read<HomeVM>();
    getFollowersList();
    if (activityId != null) {
      getPostSummary();
    }
    return super.initView();
  }

  void getPostSummary() {
    call(
        path: "Activity/goalSummary",
        method: Method.get,
        isShowLoader: false,
        queryParameters: {
          "Activity_id": activityId,
        },
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          GoalSummaryModel goalSummaryModel =
              GoalSummaryModel.fromJson(object['result']);
          List<CurrentWeekArray> currentWeekArray =
              goalSummaryModel.currentWeekArray ?? [];
          titleController.text = goalSummaryModel.activity?.habitTitle ?? "";
          skinController.text = goalSummaryModel.activity?.skinGame ?? "";
          DateTime date = DateFormat('yyyy-MM-dd')
              .parse(goalSummaryModel.activity?.startDate ?? "");
          print("Success ${date}");
          DateTime time = DateFormat("h:mm aa")
              .parse(goalSummaryModel.activity?.everyDayAt ?? "");
          dateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
          dateS(dateTime);
          addRepeat = goalSummaryModel.activity?.repeat?.type ?? 'Never';
          postVisibility = goalSummaryModel.activity?.postVisibility ??
              PostVisibility.PUBLIC;
          postVisibleTo = goalSummaryModel.activity?.visibleTo ?? [];
          notifyListeners();
        });
  }

  @override
  disposeView() {
    return super.disposeView();
  }

  updateFun(value) {
    addRepeat = value;
    notifyListeners();
  }

  void friendsList() {
    friends.clear();
    callContact(
        path: "friends/friendList",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          if (object['result'] != null) {
            object['result'].forEach((v) {
              friends.add(SendRequest.fromJson(v));
            });
          }
          if (friends.isEmpty) {
            _isNoFriend = true;
          } else {
            _isNoFriend = false;
          }
          notifyListeners();
        },
        method: Method.get,
        isShowLoader: false,
        queryParameters: {
          "userId":
              HiveUtils.getSession<String>(SessionKey.userId, defaultValue: ""),
        });
  }

  void getFollowersList() {
    String userId =
        HiveUtils.getSession<String>(SessionKey.userId, defaultValue: "");
    callContact(
        path: "friends/followers/$userId",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          try {
            if (object['result'] != null) {
              followers = object['result']
                  .map((v) => UserFollowModel.fromJson(v))
                  .cast<UserFollowModel>()
                  .toList();
            }
          } catch (e) {
            print(e);
          }
          notifyListeners();
        },
        method: Method.get,
        isShowLoader: false,
        queryParameters: {"search": ''});
  }

  void addActivity() {
    if (detail.currentState!.validate()) {
      callMap(
          path: "Activity/addActivity",
          onSuccess: (statusCode, data) {
            Map object = jsonDecode(data);
            titleController.text = "";
            skinController.text = "";
            date = "";
            addRepeat = "Never";
            repeatVm.selectedindex = 0;
            homeVm.getGoal();

            // context.read<HomeVM>().setPage(0);
            // context.read<ProfileVM>().setPage(0);
            context.pushAndRemoveUntil(const BaseHome());
          },
          method: Method.post,
          params: {
            "habitTitle": titleController.text.toString(),
            "skinGame": skinController.text,
            "startDate":
                date.isEmpty ? DateFormat('yyyy-MM-dd').format(dateTime) : date,
            "everyDayAt": DateFormat.jm().format(dateTime),
            "repeat": {
              "type": addRepeat.toString(),
              "frequency": customVm.frequency.toString(),
              "every": {
                "type": HiveUtils.getSession<String>(SessionKey.every,
                    defaultValue: ""),
                "frequency": HiveUtils.getSession<String>(SessionKey.everyfre,
                    defaultValue: "")
              },
              "days": customVm.selectedWeek
            },
            "visibility": postVisibility.name,
            "visibleTo": postVisibleTo.map((e) => e.uId).toList()
          });
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }

  void editActivity() {
    if (detail.currentState!.validate()) {
      callMap(
          path: "Activity/updateActivity",
          onSuccess: (statusCode, data) {
            Map object = jsonDecode(data);
            context.pop();
          },
          isShowLoader: false,
          method: Method.put,
          params: {
            "_id": HiveUtils.getSession<String>(SessionKey.activityId,
                defaultValue: ""),
            "habitTitle": titleController.text.toString(),
            "skinGame": skinController.text,
            "startDate":
                date.isEmpty ? DateFormat('yyyy-MM-dd').format(dateTime) : date,
            "everyDayAt": DateFormat.jm().format(dateTime),
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
            },
            "visibility": postVisibility.name,
            "visibleTo": postVisibleTo.map((e) => e.uId).toList()
          });
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }
}
