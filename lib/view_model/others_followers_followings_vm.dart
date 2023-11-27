import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jpshua/model/get_sent_request_model.dart';
import 'package:jpshua/model/goal_model.dart';
import 'package:jpshua/view_model/base_vm.dart';
import '../constants/Toasty.dart';
import '../model/user_follow_model.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class OthersFollowersFollowingsVM extends BaseViewModel {
  int _tabPage = 0;
  List<UserFollowModel> _followings = [];
  List<UserFollowModel> _followers = [];
  List<UserFollowModel> _myFollowings = [];
  PageController pageController = PageController(initialPage: 0);
  String? name;
  List<UserFollowModel> get followings => _followings;
  List<UserFollowModel> get followers => _followers;
  List<UserFollowModel> get myFollowings => _myFollowings;
  int followingsCount = 0;
  int followersCount = 0;

  @override
  disposeView() {
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(0);
    }
    return super.disposeView();
  }

  @override
  initView() {
    name = HiveUtils.getSession<String>(SessionKey.selectedUserName,
        defaultValue: "");
    getFollowers();
    getMyFollowings();
    getFollowings();
    pageController = PageController(initialPage: 0);
    _tabPage = 0;
    return super.initView();
  }

  int get tabPage => _tabPage;

  set tabPage(int value) {
    _tabPage = value;
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(value);
    }
    notifyListeners();
  }

  void follow(String userId, {VoidCallback? callback = null}) {
    call(
      path: "friends/requestFollow/${userId}",
      onSuccess: (statusCode, data) {
        callback?.call();
        notifyListeners();
      },
      isShowLoader: false,
      method: Method.post,
    );
  }

  void unfollow(String userId, {VoidCallback? callback = null}) {
    call(
      path: "friends/unfollow/${userId}",
      onSuccess: (statusCode, data) {
        callback?.call();
        notifyListeners();
      },
      isShowLoader: false,
      method: Method.post,
    );
  }

  void getFollowings() {
    String userId = HiveUtils.getSession<String>(SessionKey.selectedUserId,
        defaultValue: "");
    print('followings for $userId');
    call(
        path: "friends/followings/$userId",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          _followings = object['result']?.map<UserFollowModel>((json) {
            return UserFollowModel.fromJson(json);
          }).toList();
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.get,
        queryParameters: {"search": ''});
  }

  void getMyFollowings() {
    String userId =
        HiveUtils.getSession<String>(SessionKey.userId, defaultValue: "");
    call(
        path: "friends/followings/$userId",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          _myFollowings = object['result']?.map<UserFollowModel>((json) {
            return UserFollowModel.fromJson(json);
          }).toList();
          followingsCount = _followings.length;
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.get,
        queryParameters: {'search': ''});
  }

  void getFollowers() {
    String userId = HiveUtils.getSession<String>(SessionKey.selectedUserId,
        defaultValue: "");
    call(
        path: "friends/followers/$userId",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          _followers = object['result']?.map<UserFollowModel>((json) {
            return UserFollowModel.fromJson(json);
          }).toList();
          followersCount = _followers.length;
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.get,
        queryParameters: {'search': ''});
  }

  void searchFollowings({String search = ''}) {
    String userId = HiveUtils.getSession<String>(SessionKey.selectedUserId,
        defaultValue: "");
    call(
        path: "friends/followings/$userId",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          _followings = object['result']?.map<UserFollowModel>((json) {
            return UserFollowModel.fromJson(json);
          }).toList();
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.get,
        queryParameters: {'search': search});
  }

  void searchFollowers({String search = ''}) {
    String userId = HiveUtils.getSession<String>(SessionKey.selectedUserId,
        defaultValue: "");
    call(
        path: "friends/followers/$userId",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          _followers = object['result']?.map<UserFollowModel>((json) {
            return UserFollowModel.fromJson(json);
          }).toList();
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.get,
        queryParameters: {'search': search});
  }
}
