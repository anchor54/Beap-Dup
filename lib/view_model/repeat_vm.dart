import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/create_or_edit_goal_vm.dart';
import 'package:provider/provider.dart';

import '../model/week_model.dart';
import '../screen/custom.dart';

class RepeatVM extends BaseViewModel {
  int _indexValue = 0;
  List<WeekModel> repeat = [];
  int get indexValue => _indexValue;
  late CreateOrEditGoalVM createOrEditGoalVM;
  bool customClickStatus = false;
  int selectedindex = 0;

  // set indexValue(int value) {
  //   _indexValue = value;
  //   notifyListeners();
  // }

  @override
  initView() {
    createOrEditGoalVM = context.read<CreateOrEditGoalVM>();
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
    if (customClickStatus != true) {
      repeat[selectedindex].status = true;
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
    selectedindex = index;
    for (var i = 0; i < repeat.length; i++) {
      if (index != i) {
        repeat[i].status = false;
      }
    }
    createOrEditGoalVM.addRepeat = repeat[index].name.toString();
    print("------nnnnn----${createOrEditGoalVM.addRepeat}");
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
