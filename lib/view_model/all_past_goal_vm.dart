import 'dart:convert';

import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/profile_vm.dart';
import 'package:provider/provider.dart';

import '../constants/Toasty.dart';
import '../model/goal_model.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import 'home_vm.dart';

class PastGoalVM extends BaseViewModel{

  List<GoalModel> activeGoal = [];
  bool _isNoData = false;
  late HomeVM homeVm;
  late ProfileVM profileVm;
  int num = int.parse(HiveUtils.getSession<String>(SessionKey.goalCount));
  @override
  initView() {
    profileVm = context.read<ProfileVM>();
    homeVm = context.read<HomeVM>();
    _isNoData = false;
    getActiveGoal();
    return super.initView();
  }
  bool get isNoData => _isNoData;

  set isNoData(bool value) {
    _isNoData = value;
    notifyListeners();
  }
  void getActiveGoal(){
    activeGoal.clear();
    String userId = HiveUtils.getSession<String>(SessionKey.userId, defaultValue: "");
    call(path: "Activity/getActivety/$userId", onSuccess: (statusCode, data) {
      Map object = jsonDecode(data);
      if (object['result'] != null) {
        object['result'].forEach((v) {
          activeGoal.add(GoalModel.fromJson(v));
        });
      }
      if(activeGoal.isEmpty){
        _isNoData = true;
      }else{
        _isNoData = false;
      }
      notifyListeners();

    },
      method: Method.get,isShowLoader:false, queryParameters: {
        "goal":"pastGoal",
      },
    );

  }
  void deleteGoal(index){
    call(path: "Activity/deleteActivity", onSuccess: (statusCode, data) {
      Map object = jsonDecode(data);
      Toasty.showtoast( object['message']);
      if (object['result'] != null) {
        activeGoal.removeAt(index);
        int value =num-1;
        HiveUtils.addSession(SessionKey.goalCount,value);
        homeVm.goalCount=HiveUtils.getSession(SessionKey.goalCount);
        context.read<ProfileVM>().setPage(0);
        profileVm.getActiveGoal("pastGoal");
      }
      notifyListeners();

    },
      method: Method.delete,isShowLoader:false, queryParameters: {
        "Activity_Id":HiveUtils.getSession<String>(SessionKey.activityId,
            defaultValue: ""),
      },
    );

  }


}