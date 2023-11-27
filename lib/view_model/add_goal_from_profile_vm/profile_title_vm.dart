import 'package:flutter/cupertino.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';

import '../../screen/add_goal_from_profile/start_end_date_profile.dart';


class TitleProfileVM extends BaseViewModel{
  var titleController = TextEditingController();
  GlobalKey<FormState> profileTitles = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();

  }
  @override
  initView() {
    profileTitles=GlobalKey<FormState>();
    return super.initView();
  }
  @override
  disposeView() {
    return super.disposeView();
  }
  void goToDate(){
    if(profileTitles.currentState!.validate()){
      context.pushReplacement(const StartEndDateProfileScreen());
    }
    else{
      autoValidate = AutovalidateMode.always;
    }

  }

}