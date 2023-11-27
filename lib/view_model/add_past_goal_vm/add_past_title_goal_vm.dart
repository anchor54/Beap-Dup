import 'package:flutter/cupertino.dart';
import 'package:jpshua/screen/add_active_goal/add_active_goal_start_end_date.dart';
import 'package:jpshua/screen/add_past_goal/add_past_goal_start_end_date.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';

class PastTitleVM extends BaseViewModel{
  var titleController = TextEditingController();
  GlobalKey<FormState> pastTitle = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();

  }
  @override
  initView() {
    pastTitle=GlobalKey<FormState>();
    return super.initView();
  }
  @override
  disposeView() {
    return super.disposeView();
  }
  void goToDate(){
    if(pastTitle.currentState!.validate()){
      context.pushReplacement(const PastStartEndDateScreen());
    }
    else{
      autoValidate = AutovalidateMode.always;
    }

  }

}