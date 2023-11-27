import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/home_vm.dart';
import 'package:provider/provider.dart';
import '../constants/Toasty.dart';
import '../model/goal_model.dart';
import '../screen/base_home.dart';

class CameraPreviewVM extends BaseViewModel {
  int _tabPage = 0;
  List<GoalModel> activeGoal = [];
  var filePath;
  PageController pageController = PageController(initialPage: 0);
  String _selected = "Select a habit";

  String get selectedValue => _selected;

  set selectedValue(String value) {
    _selected = value;
    notifyListeners();
  }

  @override
  initView() {
    activeGoal.clear();
    getActiveGoal();
    return super.initView();
  }

  int get tabPage => _tabPage;

  set tabPage(int value) {
    _tabPage = value;
    notifyListeners();
  }

  void getActiveGoal() {
    String userId =
        HiveUtils.getSession<String>(SessionKey.userId, defaultValue: "");
    call(
      path: "Activity/getActivety/$userId",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['result'] != null) {
          object['result'].forEach((v) {
            activeGoal.add(GoalModel.fromJson(v));
          });
          notifyListeners();
        }
      },
      method: Method.get,
      isShowLoader: false,
      queryParameters: {
        "goal": "activeGoal",
      },
    );
  }

  void uploadDailyTask() {
    print(filePath);
    if (_selected != "Select a habit") {
      callMultiPart(
          path: "Activity/dailyTask",
          onSuccess: (statusCode, data) {
            Map object = jsonDecode(data);
            // Toasty.showtoast(object['message']);
            context.pushAndRemoveUntil(const BaseHome());
            _selected = "Select a habit";
            notifyListeners();
          },
          method: Method.post,
          isShowLoader: false,
          queryParameters: {
            "Activity_id": HiveUtils.getSession<String>(SessionKey.activityId,
                defaultValue: ""),
          },
          params: {
            "habitTitle": _selected.toString(),
          },
          file: filePath != null ? File(filePath) : filePath,
          fileKey: "image");
    } else {
      Toasty.showtoast("Please Select Habit");
    }
  }
}
