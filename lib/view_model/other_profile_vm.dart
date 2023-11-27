import 'dart:convert';
import 'package:jpshua/model/goal_model.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';

class OthersProfileVM extends BaseViewModel {
  int _tabPage = 0;
  bool _isNoData = false;
  List<GoalModel> activeGoals = [];
  List<GoalModel> pastGoals = [];
  bool _isFollowing = true;
  late String uId;
  String? name, userName, bio, profileImg;

  get activeGoalsCount => activeGoals.length;
  get isFollowing => _isFollowing;

  set isFollowing(value) {
    _isFollowing = value;
    notifyListeners();
  }

  @override
  initView() {
    // need to set the selectedUserId key in the hive box before launching the screen
    uId = HiveUtils.getSession(SessionKey.selectedUserId, defaultValue: "");
    getUserDetail();
    getActiveGoals();
    getPastGoals();
    _tabPage = 0;
    return super.initView();
  }

  void getUserDetail() {
    call(
        path: 'user/getUser',
        onSuccess: (status, data) {
          Map userMap = json.decode(data);
          uId = userMap['result']['_id'];
          name = userMap['result']['name'];
          userName = userMap['result']['userName'];
          profileImg = userMap['result']['image'];
          bio = userMap['result']['bio'];
          HiveUtils.addSession(SessionKey.selectedUserName, name);
        },
        queryParameters: {
          // SessionKey.selectedUserId
          'id':
              HiveUtils.getSession(SessionKey.selectedUserId, defaultValue: "")
        });
    notifyListeners();
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

  void getActiveGoals() {
    activeGoals.clear();
    call(
      path: "Activity/getActivety/$uId",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['result'] != null) {
          object['result'].forEach((v) {
            activeGoals.add(GoalModel.fromJson(v));
          });
        }
        if (activeGoals.isEmpty) {
          _isNoData = true;
        } else {
          _isNoData = false;
        }
        notifyListeners();
      },
      method: Method.get,
      isShowLoader: false,
      queryParameters: {
        "goal": 'activeGoal',
      },
    );
  }

  void getPastGoals() {
    activeGoals.clear();
    call(
      path: "Activity/getActivety/$uId",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['result'] != null) {
          object['result'].forEach((v) {
            activeGoals.add(GoalModel.fromJson(v));
          });
        }
        if (activeGoals.isEmpty) {
          _isNoData = true;
        } else {
          _isNoData = false;
        }
        notifyListeners();
      },
      method: Method.get,
      isShowLoader: false,
      queryParameters: {
        "goal": 'pastGoal',
      },
    );
  }
}
