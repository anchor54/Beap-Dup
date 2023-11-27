import 'dart:convert';
import 'package:jpshua/screen/add_active_goal/add_active_goal_confirm_habit.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_start_end_date_vm.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_title_vm.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:provider/provider.dart';
import '../../constants/Toasty.dart';
import '../../utils/hive_utils.dart';
import '../home_vm.dart';
import '../profile_vm.dart';

class ActiveFrequentVM extends BaseViewModel{
  List week = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  int num = int.parse(HiveUtils.getSession<String>(SessionKey.goalCount));
  List weekSelectStatus = ['0','0','0','0','0','0','0'];
  List selectedList=[];
  String _time='1';
  String _sec='30';
  String _duration='PM';
  List <String>selectedWeek=[];
  bool _rememberCheck = false;
  bool get rememberCheck => _rememberCheck;

  set rememberCheck(bool value) {
    _rememberCheck = value;
    notifyListeners();
  }
  late ActiveTitleVM titleVm;
  late ActiveStartEndDateVM startEndVm;
  @override
  initView() {
    titleVm = context.read<ActiveTitleVM>();
    startEndVm = context.read<ActiveStartEndDateVM>();
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
      context.pushAndRemoveUntil(const ActiveConfirmHabit());
    },method: Method.post,params: {
      "habitTitle":titleVm.titleController.text.toString(),
      "startDate":startEndVm.startDateController.text.toString(),
      "endDate":startEndVm.endDateController.text.toString(),
      "everyWeekOn":selectedWeek.toString(),
      "everyDayAt":"$time${":"}$sec${" "}$duration",
    });




  }

}