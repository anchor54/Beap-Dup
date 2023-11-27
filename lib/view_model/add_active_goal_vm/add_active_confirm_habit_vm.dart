import 'package:jpshua/screen/join_habit.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_frequent_vm.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_start_end_date_vm.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_title_vm.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/profile_frequent_vm.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/profile_title_vm.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/start_end_date_profilevm.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:provider/provider.dart';

class ActiveConfirmHabitVM extends BaseViewModel{
  late ActiveTitleVM titleVm;
  late ActiveStartEndDateVM startEndVm;
  late ActiveFrequentVM frequentVm;
  String habits="";
  @override
  initView() {
    titleVm = context.read<ActiveTitleVM>();
    startEndVm = context.read<ActiveStartEndDateVM>();
    frequentVm = context.read<ActiveFrequentVM>();
    habits=frequentVm.selectedWeek.toString();
    print("---------hbits-----${habits.toString()}");
    return super.initView();
  }
  void gotoConfirm(){
    titleVm.titleController.clear();
    startEndVm.endDateController.clear();
    startEndVm.startDateController.clear();
    frequentVm.selectedWeek.clear();
    frequentVm.weekSelectStatus=['0','0','0','0','0','0','0'];
    frequentVm.duration="PM";
    frequentVm.sec="30";
    frequentVm.time="1";
    context.pushReplacement(const JoinHabit());

  }

}