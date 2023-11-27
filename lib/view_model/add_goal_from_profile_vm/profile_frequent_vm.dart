import 'dart:convert';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/profile_title_vm.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/start_end_date_profilevm.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:provider/provider.dart';
import '../../constants/Toasty.dart';
import '../../screen/add_goal_from_profile/confirm_habit_profile.dart';
import '../home_vm.dart';
import '../profile_vm.dart';

class FrequentProfileVM extends BaseViewModel{
  List week = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  List weekSelectStatus = ['0','0','0','0','0','0','0'];
  int num = int.parse(HiveUtils.getSession<String>(SessionKey.goalCount));
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
  late TitleProfileVM titleVm;
  late StartEndDateProfileVM startEndVm;
  @override
  initView() {
    titleVm = context.read<TitleProfileVM>();
    startEndVm = context.read<StartEndDateProfileVM>();
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
      context.pushReplacement(const ConfirmHabitProfile());
    },method: Method.post,params: {
      "habitTitle":titleVm.titleController.text.toString(),
      "startDate":startEndVm.startDateController.text.toString(),
      "endDate":startEndVm.endDateController.text.toString(),
      "everyWeekOn":selectedWeek.toString(),
      "everyDayAt":"$time${":"}$sec${" "}$duration",
    });




  }

}