import 'package:jpshua/screen/join_habit.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:provider/provider.dart';
import 'add_past_goal_frequent_vm.dart';
import 'add_past_goal_start_end_date_vm.dart';
import 'add_past_title_goal_vm.dart';

class PastConfirmHabitVM extends BaseViewModel{
  late PastTitleVM titleVm;
  late PastStartEndDateVM startEndVm;
  late PastFrequentVM frequentVm;
  String habits="";
  @override
  initView() {
    titleVm = context.read<PastTitleVM>();
    startEndVm = context.read<PastStartEndDateVM>();
    frequentVm = context.read<PastFrequentVM>();
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