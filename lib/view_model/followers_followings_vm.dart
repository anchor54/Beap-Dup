import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:jpshua/view_model/base_vm.dart';
import '../model/user_follow_model.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class FollowersFollowingsVM extends BaseViewModel {
  int _tabPage = 0;
  List<UserFollowModel> _followings = [];
  List<UserFollowModel> _followers = [];
  PageController pageController = PageController(initialPage: 0);
  String? name;
  List<UserFollowModel> get followings => _followings;
  List<UserFollowModel> get followers => _followers;
  int _followingsCount = 0;
  int _followersCount = 0;
  get followingsCount => _followingsCount;
  get followersCount => _followersCount;

  @override
  disposeView() {
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(0);
    }
    return super.disposeView();
  }

  @override
  initView() {
    name = HiveUtils.getSession<String>(SessionKey.name, defaultValue: "");
    _getFollowers();
    _getFollowings();
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

  void follow(String userId, {Function()? callback = null}) {
    call(
      path: "friends/requestFollow/${userId}",
      onSuccess: (statusCode, data) {
        int index = _followings.indexWhere((element) => element.uId == userId);
        if (index == -1) return;
        callback?.call();
        notifyListeners();
      },
      isShowLoader: false,
      method: Method.post,
    );
  }

  void unfollow(String userId, {Function()? callback = null}) {
    call(
      path: "friends/unfollow/${userId}",
      onSuccess: (statusCode, data) {
        int index = _followings.indexWhere((element) => element.uId == userId);
        if (index == -1) return;
        callback?.call();
        notifyListeners();
      },
      isShowLoader: false,
      method: Method.post,
    );
  }

  void removeFollower(String userId, {VoidCallback? callback = null}) {
    call(
      path: "friends/remove-follower/${userId}",
      onSuccess: (statusCode, data) {
        int? index = _followers.indexWhere((element) => element.uId == userId);
        if (index == -1) return;
        _followers.removeAt(index);
        callback?.call();
        notifyListeners();
      },
      isShowLoader: false,
      method: Method.post,
    );
  }

  void _getFollowings() {
    String userId =
        HiveUtils.getSession<String>(SessionKey.userId, defaultValue: "");
    print('followings for $userId');
    call(
        path: "friends/followings/$userId",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          _followings = object['result']?.map<UserFollowModel>((json) {
            return UserFollowModel.fromJson(json);
          }).toList();
          _followingsCount = _followings.length;
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.get,
        queryParameters: {"search": ''});
  }

  void _getFollowers() {
    String userId =
        HiveUtils.getSession<String>(SessionKey.userId, defaultValue: "");
    call(
        path: "friends/followers/$userId",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          _followers = object['result']?.map<UserFollowModel>((json) {
            return UserFollowModel.fromJson(json);
          }).toList();
          _followersCount = _followers.length;
          notifyListeners();
        },
        isShowLoader: false,
        method: Method.get,
        queryParameters: {"search": ''});
  }

  void searchFollowings({String search = ""}) {
    String userId =
        HiveUtils.getSession<String>(SessionKey.userId, defaultValue: "");
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
        queryParameters: {"search": search});
  }

  void searchFollowers({String search = ""}) {
    String userId =
        HiveUtils.getSession<String>(SessionKey.userId, defaultValue: "");
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
        queryParameters: {
          "search": search,
        });
  }
}
