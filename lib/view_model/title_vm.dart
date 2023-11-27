import 'package:flutter/cupertino.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';

import '../screen/StarEndDate.dart';

class TitleVM extends BaseViewModel{
  var titleController = TextEditingController();
  GlobalKey<FormState> titles = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();

  }
  @override
  initView() {
    // titles=GlobalKey<FormState>();
    return super.initView();
  }
  @override
  disposeView() {
    return super.disposeView();
  }
  void goToDate(){
    if(titles.currentState!.validate()){
      context.pushReplacement(const StartEndDateScreen());
    }
    else{
      autoValidate = AutovalidateMode.always;
    }

  }

}