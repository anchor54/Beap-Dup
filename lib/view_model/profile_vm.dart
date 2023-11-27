import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jpshua/model/goal_model.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/followers_followings_vm.dart';
import 'package:provider/provider.dart';
import '../constants/Toasty.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class ProfileVM extends BaseViewModel {
  int _tabPage = 0;
  bool _isNoData = false;
  List<GoalModel> activeGoal = [];
  List<String> _selectedFriendIds = [];
  PageController pageController = PageController(initialPage: 0);
  late String filePath, name, userName, bio, _profileImg;
  get profileImg => _profileImg;
  get selectedFriendIds => _selectedFriendIds;

  set profileImg(value) {
    _profileImg = value;
    notifyListeners();
  }

  @override
  disposeView() {
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(0);
    }
    return super.disposeView();
  }

  @override
  initView() {
    _isNoData = false;
    _profileImg = HiveUtils.getSession<String>(SessionKey.image) != "null"
        ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
        : "";
    name = HiveUtils.getSession<String>(SessionKey.name, defaultValue: "");
    userName =
        HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "");
    bio = HiveUtils.getSession<String>(SessionKey.bio, defaultValue: "");
    getActiveGoal("activeGoal");
    getUserDetail();
    pageController = PageController(initialPage: 0);
    _tabPage = 0;
    return super.initView();
  }

  void setPage(int page) {
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(page);
    }
  }

  void getUserDetail() {
    call(
        path: 'user/getUser',
        onSuccess: (status, data) {
          Map userMap = json.decode(data);
          name = userMap['result']['name'];
          userName = userMap['result']['userName'];
          profileImg = userMap['result']['image'];
          bio = userMap['result']['bio'];
          HiveUtils.addSession(SessionKey.selectedUserName, name);
          notifyListeners();
        },
        isShowLoader: false,
        queryParameters: {
          // SessionKey.selectedUserId
          'id': HiveUtils.getSession(SessionKey.userId, defaultValue: "")
        });
  }

  int get tabPage => _tabPage;

  set tabPage(int value) {
    _tabPage = value;
    notifyListeners();
  }

  bool get isNoData => _isNoData;

  set isNoData(bool value) {
    _isNoData = value;
    notifyListeners();
  }

  void getActiveGoal(status) {
    activeGoal.clear();
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
        }
        if (activeGoal.isEmpty) {
          _isNoData = true;
        } else {
          _isNoData = false;
        }
        notifyListeners();
      },
      method: Method.get,
      isShowLoader: false,
      queryParameters: {
        "goal": status,
      },
    );
  }

  void addFriend(String? friendId) {
    print("add friend called");
    if (friendId != null && !_selectedFriendIds.contains(friendId)) {
      _selectedFriendIds.add(friendId);
      notifyListeners();
    }
  }

  void removeFriend(String? friendId) {
    if (friendId != null && _selectedFriendIds.contains(friendId)) {
      print("removeFriend: $friendId");
      _selectedFriendIds.remove(friendId);
      notifyListeners();
    }
  }

  void makeGoalPublic(String goalId) {
    call(
        path: "Activity/editActivityVisibility/${goalId}",
        onSuccess: (statusCode, data) {
          int index = activeGoal.indexWhere((element) => element.sId == goalId);
          if (index == -1) return;
          activeGoal[index].visibility = GoalVisibility.PUBLIC;
          activeGoal[index].visibleToIds = [];
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.put,
        params: {
          "visibility": "Public",
          "visibleToIds": {"\"visibleToIds\"": "[]"}.toString(),
        });
  }

  void makeGoalPrivate(String goalId, List<String> visibleToIds) {
    print("visible ids: ${visibleToIds.join(", ")}");
    call(
        path: "Activity/editActivityVisibility/${goalId}",
        onSuccess: (statusCode, data) {
          int index = activeGoal.indexWhere((element) => element.sId == goalId);
          if (index == -1) return;
          activeGoal[index].visibility = GoalVisibility.PUBLIC;
          activeGoal[index].visibleToIds = [];
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.put,
        params: {
          "visibility": "Private",
          "visibleToIds": {
            "\"visibleToIds\"":
                "[${visibleToIds.map((e) => "\"$e\"").join(",")}]"
          }.toString(),
        });
  }

  void deleteGoal(String? goalId) {
    call(
        path: "Activity/deleteActivity",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          if (object['result'] != null) {
            int index =
                activeGoal.indexWhere((element) => element.sId == goalId);
            if (index == -1) return;
            activeGoal.removeAt(index);
            HiveUtils.addSession(SessionKey.goalCount, activeGoal.length);
          }
          notifyListeners();
        },
        method: Method.delete,
        isShowLoader: false,
        queryParameters: {
          "Activity_Id": goalId,
        });
  }
}
