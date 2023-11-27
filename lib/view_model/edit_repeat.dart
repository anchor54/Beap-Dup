import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/edit_goal_vm.dart';
import 'package:provider/provider.dart';
import '../model/week_model.dart';
import '../screen/custom.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class EditRepeatVM extends BaseViewModel {
  bool customClickStatus = false;
  late int selectedIndex;
  List<WeekModel> repeat = [];
  late EditGoalVM CreateOrEditGoalVM;

  @override
  initView() {
    CreateOrEditGoalVM = context.read<EditGoalVM>();
    print("-------default selected--${CreateOrEditGoalVM.addRepeat}");
    repeat = [
      WeekModel(id: 1, name: 'Never', status: false),
      WeekModel(id: 2, name: 'Daily', status: false),
      WeekModel(id: 3, name: 'Weekdays', status: false),
      WeekModel(id: 4, name: 'Weekends', status: false),
      WeekModel(id: 5, name: 'Weekly', status: false),
      WeekModel(id: 6, name: 'Biweekly', status: false),
      WeekModel(id: 7, name: 'Monthly', status: false),
      WeekModel(id: 8, name: 'Every 3 Months', status: false),
      WeekModel(id: 9, name: 'Every 6 Months', status: false),
      WeekModel(id: 10, name: 'Yearly', status: false),
    ];
    if (CreateOrEditGoalVM.addRepeat == "Custom Repeat") {
      customClickStatus = true;
      for (var i = 0; i < repeat.length; i++) {
        repeat[i].status = false;
      }
    } else {
      for (var i = 0; i < repeat.length; i++) {
        if (repeat[i].name == CreateOrEditGoalVM.addRepeat) {
          repeat[i].status = true;
          selectedIndex = i;
          customClickStatus = false;
        }
      }
    }
    if (customClickStatus != true) {
      repeat[selectedIndex].status = true;
    }
    return super.initView();
  }

  @override
  disposeView() {
    return super.disposeView();
  }

  void repeatFun(index, status) {
    customClickStatus = false;
    repeat[index].status = true;
    selectedIndex = index;
    for (var i = 0; i < repeat.length; i++) {
      if (index != i) {
        repeat[i].status = false;
        print("hellooo");
      }
    }
    CreateOrEditGoalVM.addRepeat = repeat[index].name.toString();
    // HiveUtils.addSession(SessionKey.selectedId,repeat[index].id.toString());
    print(CreateOrEditGoalVM.addRepeat);
    notifyListeners();
  }

  void customClick() {
    customClickStatus = true;
    for (var i = 0; i < repeat.length; i++) {
      repeat[i].status = false;
    }
    notifyListeners();
  }
}
