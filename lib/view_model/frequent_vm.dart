import 'dart:convert';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/profile_vm.dart';
import 'package:jpshua/view_model/start_end_vm.dart';
import 'package:jpshua/view_model/title_vm.dart';
import 'package:provider/provider.dart';

import '../constants/Toasty.dart';
import '../screen/confirm_habit.dart';
import '../utils/hive_utils.dart';
import 'home_vm.dart';

class FrequentVM extends BaseViewModel{
  List week = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  List weekSelectStatus = ['0','0','0','0','0','0','0'];
  List selectedList=[];
  String _time='1';
  String _sec='30';
  String _duration='PM';
  List <String>selectedWeek=[];
  bool _rememberCheck = false;
  int num = int.parse(HiveUtils.getSession<String>(SessionKey.goalCount));
  bool get rememberCheck => _rememberCheck;

  set rememberCheck(bool value) {
    _rememberCheck = value;
    notifyListeners();
  }
  late TitleVM titleVm;
  late StartEndDateVM startEndVm;
  @override
  initView() {
    titleVm = context.read<TitleVM>();
    startEndVm = context.read<StartEndDateVM>();
    return super.initView();
  }
  set time(value) {
    _time = value;
    notifyListeners();
  }
  get time => _time;


  set sec(value) {
    _sec = value;
    notifyListeners();
  }
  get sec => _sec;

  set duration(value) {
    _duration = value;
    notifyListeners();
  }
  get duration => _duration;
  void selected(i){
    weekSelectStatus[i]="1";
    print(weekSelectStatus);
    notifyListeners();

  }
  void unselected(i){
    weekSelectStatus[i]="0";
    print(weekSelectStatus);
    notifyListeners();

  }


  void goToFrequent(){
    selectedWeek.clear();
    for(int i=0; i<weekSelectStatus.length; i++){
      if(weekSelectStatus[i]=="1"){
        selectedWeek.add(week[i].toString());
        notifyListeners();
      }
    }
    call(path: "Activity/addActivity", onSuccess: (statusCode, data) {
      Map object = jsonDecode(data);
      Toasty.showtoast(object['message']);
      HiveUtils.addSession(SessionKey.habitName, object['result']['habitTitle'].toString());
      HiveUtils.addSession(SessionKey.goalId, object['result']['_id'].toString());
      int value =num+1;
      HiveUtils.addSession(SessionKey.goalCount,value);
      context.read<HomeVM>().setPage(0);
      context.read<ProfileVM>().setPage(0);
      context.pushReplacement(const ConfirmHabit());
    },method: Method.post,params: {
      "habitTitle":titleVm.titleController.text.toString(),
      "startDate":startEndVm.startDateController.text.toString(),
      "endDate":startEndVm.endDateController.text.toString(),
      "everyWeekOn":selectedWeek.toString(),
      "everyDayAt":"$time${":"}$sec${" "}$duration",
    }
    );




  }

}