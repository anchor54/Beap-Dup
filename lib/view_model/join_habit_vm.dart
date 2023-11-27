import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/past_goal_summay_vm.dart';
import 'package:provider/provider.dart';
import '../constants/Toasty.dart';
import '../model/goal_friends_model.dart';
import '../model/sent_request_model.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class JoinHabitVM extends BaseViewModel {
  var searchController = TextEditingController();
  List<GoalFriendsModel> friendList = [];
  int _status = -1;
  String? _profileImg;
  get profileImg => _profileImg;
  late GoalSummaryVM goalSummaryVM;

  set profileImg(value) {
    _profileImg = value;
    notifyListeners();
  }

  @override
  disposeView() {
    return super.disposeView();
  }

  bool _isNoData = false;
  bool _isCallNoData = true;
  int contactPos = 0;
  String path = "";
  bool get isNoData => _isNoData;

  set isNoData(bool value) {
    _isNoData = value;
  }

  bool get isCallNoData => _isCallNoData;

  set isCallNoData(bool value) {
    _isCallNoData = value;
    notifyListeners();
  }

  int get status => _status;

  set status(int value) {
    _status = value;
    notifyListeners();
  }

  @override
  initView() {
    _isNoData = false;
    _status = -1;
    goalSummaryVM = context.read<GoalSummaryVM>();
    _profileImg = HiveUtils.getSession<String>(SessionKey.image) != "null"
        ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
        : "";
    friendsList();
    return super.initView();
  }

  void friendsList() {
    friendList.clear();
    callContact(
        path: "friends/goalfriendList",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          if (object['result'] != null) {
            object['result'].forEach((v) {
              friendList.add(GoalFriendsModel.fromJson(v));
            });
          }
          if (friendList.isEmpty) {
            _isNoData = true;
          } else {
            _isNoData = false;
          }
          notifyListeners();
        },
        method: Method.get,
        isShowLoader: false,
        queryParameters: {
          "userId":
              HiveUtils.getSession<String>(SessionKey.userId, defaultValue: ""),
          "goalId":
              HiveUtils.getSession<String>(SessionKey.goalId, defaultValue: ""),
        });
  }

  void sendInivition(index, status) {
    notifyListeners();
    call(
      path: "Activity/inviteToGoal",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['success'] = true) {
          if (friendList[index].isInvitedInGoal = true) {
            friendList[index].isInvitedInGoal == false;
          } else if (friendList[index].isInvitedInGoal = false) {
            friendList[index].isInvitedInGoal == true;
          }
          // status==index;
          goalSummaryVM.getPostSummary();
          Toasty.showtoast(object['message']);
        }
        notifyListeners();
      },
      method: Method.post,
      isShowLoader: false,
      params: {
        "goalId":
            HiveUtils.getSession<String>(SessionKey.goalId, defaultValue: ""),
        "invitedId":
            HiveUtils.getSession<String>(SessionKey.invitedId, defaultValue: "")
      },
    );
  }
}
