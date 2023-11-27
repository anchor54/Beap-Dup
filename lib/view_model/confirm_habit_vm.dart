import 'package:jpshua/screen/join_habit.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/frequent_vm.dart';
import 'package:jpshua/view_model/start_end_vm.dart';
import 'package:jpshua/view_model/title_vm.dart';
import 'package:provider/provider.dart';

class ConfirmHabitVM extends BaseViewModel{
  late TitleVM titleVm;
  late StartEndDateVM startEndVm;
  late FrequentVM frequentVm;
  String habits="";
  @override
  initView() {
    titleVm = context.read<TitleVM>();
    startEndVm = context.read<StartEndDateVM>();
    frequentVm = context.read<FrequentVM>();
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