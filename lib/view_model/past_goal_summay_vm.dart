import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:jpshua/model/goal_summary_model.dart';
import 'package:jpshua/utils/appStrings.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/goal_summary_model.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class GoalSummaryVM extends BaseViewModel {
  late final DateTime focusedDay = DateTime.now();
  GoalSummaryModel? goalSummaryModel = null;

  @override
  initView() {
    getPostSummary();
    return super.initView();
  }

  void getPostSummary() {
    call(
      path: "Activity/goalSummary",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        goalSummaryModel = GoalSummaryModel.fromJson(object['result']);
        HiveUtils.addSession(
            SessionKey.habitName, object['result']['habitTitle'].toString());
        notifyListeners();
      },
      method: Method.get,
      isShowLoader: false,
      queryParameters: {
        "Activity_id": HiveUtils.getSession<String>(SessionKey.activityId,
            defaultValue: ""),
      },
    );
  }
}
