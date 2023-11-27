import 'package:jpshua/view_model/base_vm.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NotificationVM extends BaseViewModel{
  bool isSwitched = false;
  bool isSwitchedFrd = false;
  bool isSwitchedHabit = false;
  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      isSwitched = true;
    }
    else
    {
      isSwitched = false;
    }
    notifyListeners();
  }
  void toggleSwitchFrd(bool value) {

    if(isSwitchedFrd == false)
    {
      isSwitchedFrd = true;
    }
    else
    {
      isSwitchedFrd = false;
    }
    notifyListeners();
  }
  void toggleSwitchHabit(bool value) {

    if(isSwitchedHabit == false)
    {
      isSwitchedHabit = true;
    }
    else
    {
      isSwitchedHabit = false;
    }
    notifyListeners();
  }

}