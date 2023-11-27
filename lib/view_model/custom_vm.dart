import '../model/week_model.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import 'base_vm.dart';

class CustomVM extends BaseViewModel {
  int _indexFreqValue = 0;
  int _indexEveryValue = 0;
  List<WeekModel> Weeks = [];
  List<WeekModel> months = [];
  String frequency = "Daily";
  
  void toggleDaySelection(i) {
    Weeks[i].status = !Weeks[i].status;
    selectedWeek = Weeks.where((element) => element.status).map((month) => month.name).toList();
    if (selectedWeek.length == Weeks.length) {
      occur = "day";
    } else {
      occur = selectedWeek.sublist(0, selectedWeek.length - 1).join(', ');
      occur +=
          '${(selectedWeek.length > 1) ? " and " : ""}${selectedWeek[selectedWeek.length - 1]}';
    }
    notifyListeners();
  }

  void toggleMonthSelection(i) {
    months[i].status = !months[i].status;
    selectedMonths = months.where((element) => element.status).map((month) => month.name).toList();
    if (selectedMonths.length == months.length) {
      occur = "month";
    } else {
      occur = selectedMonths.sublist(0, selectedMonths.length - 1).join(', ');
      occur +=
          '${(selectedMonths.length > 1) ? " and " : ""}${selectedMonths[selectedMonths.length - 1]}';
    }
    notifyListeners();
  }

  String every = "Day";
  String occur = "day";
  String tempOccur = "";
  int get indexFreqValue => _indexFreqValue;

  set indexFreqValue(int value) {
    _indexFreqValue = value;
    notifyListeners();
  }

  int get indexEveryValue => _indexEveryValue;

  set indexEveryValue(int value) {
    _indexEveryValue = value;
    notifyListeners();
  }

  bool _isFrequencyTime = false;
  bool _isEveryTime = false;
  bool get isFrequencyTime => _isFrequencyTime;
  bool get isEveryTime => _isEveryTime;
  set isFrequencyTime(bool value) {
    if (_isFrequencyTime == false) {
      _isFrequencyTime = true;
    } else {
      _isFrequencyTime = false;
    }
    notifyListeners();
  }

  set isEveryTime(bool value) {
    if (_isEveryTime == false) {
      _isEveryTime = true;
    } else {
      _isEveryTime = false;
    }
    notifyListeners();
  }

  List frequent = ["Daily", "Weekly", "Monthly"];
  List<String> selectedWeek = [];
  List<String> selectedMonths = [];
  List<String> selectedWeektemp = [];
  List<String> selectedMonthtemp = [];
  List selectedList = [];
  List daily = [];
  @override
  initView() {
    _isFrequencyTime = false;
    _isEveryTime = false;
    for (int i = 1; i < 1000; i++) {
      daily.add(i);
    }
    Weeks = [
      WeekModel(id: 1, name: 'Sunday', status: false),
      WeekModel(id: 2, name: 'Monday', status: false),
      WeekModel(id: 3, name: 'Tuesday', status: false),
      WeekModel(id: 4, name: 'Wednesday', status: false),
      WeekModel(id: 5, name: 'Thursday', status: false),
      WeekModel(id: 6, name: 'Friday', status: false),
      WeekModel(id: 7, name: 'Saturday', status: false),
    ];
    months = [
      WeekModel(id: 1, name: '1st', status: false),
      WeekModel(id: 2, name: '2nd', status: false),
      WeekModel(id: 3, name: '3rd', status: false),
      WeekModel(id: 4, name: '4th', status: false),
      WeekModel(id: 5, name: '5th', status: false),
      WeekModel(id: 6, name: '6th', status: false),
      WeekModel(id: 7, name: '7th', status: false),
      WeekModel(id: 8, name: '8th', status: false),
      WeekModel(id: 9, name: '9th', status: false),
      WeekModel(id: 10, name: '10th', status: false),
      WeekModel(id: 11, name: '11th', status: false),
      WeekModel(id: 12, name: '12th', status: false),
      WeekModel(id: 13, name: '13th', status: false),
      WeekModel(id: 14, name: '14th', status: false),
      WeekModel(id: 15, name: '15th', status: false),
      WeekModel(id: 16, name: '16th', status: false),
      WeekModel(id: 17, name: '17th', status: false),
      WeekModel(id: 18, name: '18th', status: false),
      WeekModel(id: 19, name: '19th', status: false),
      WeekModel(id: 20, name: '20th', status: false),
      WeekModel(id: 21, name: '21th', status: false),
      WeekModel(id: 22, name: '22th', status: false),
      WeekModel(id: 23, name: '23th', status: false),
      WeekModel(id: 24, name: '24th', status: false),
      WeekModel(id: 25, name: '25th', status: false),
      WeekModel(id: 26, name: '26th', status: false),
      WeekModel(id: 27, name: '27th', status: false),
      WeekModel(id: 28, name: '28th', status: false),
      WeekModel(id: 29, name: '29th', status: false),
      WeekModel(id: 30, name: '30th', status: false),
      WeekModel(id: 31, name: '31th', status: false),
    ];
    return super.initView();
  }

  @override
  disposeView() {
    return super.disposeView();
  }

  void onweakChange(frequently) {
    occur = tempOccur;
    print("-------selectedWeek-----$selectedWeek");
    for (int i = 0; i < selectedWeek.length; i++) {
      if (occur == tempOccur) {
        if (frequently == "Weekly") {
          occur = "$occur${" on "}${selectedWeek[i].toString()}";
        } else if (frequently == "Monthly") {
          occur = "$occur${" on the "}${selectedWeek[i].toString()}";
        }
      } else {
        occur = "$occur${", "}${selectedWeek[i].toString()}";
      }
    }
    notifyListeners();
  }
}
