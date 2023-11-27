import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/screen/add_past_goal/add_past_goal_frequent.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../constants/Toasty.dart';

class PastStartEndDateVM extends BaseViewModel{
  var start = MaskTextInputFormatter(mask: '##-##-####', filter: { "#": RegExp(r'[0-9]') });
  var end = MaskTextInputFormatter(mask: '##-##-####', filter: { "#": RegExp(r'[0-9]') });
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  GlobalKey<FormState> pastDate = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }
  @override
  initView() {
    pastDate=GlobalKey<FormState>();
    return super.initView();
  }
  void goToFromDate(){
    if(pastDate.currentState!.validate()){
      DateTime dt1 =  DateFormat('MM-dd-yyyy').parse(startDateController.text.toString());
      DateTime dt2 = DateFormat('MM-dd-yyyy').parse(endDateController.text.toString());
      if(dt1.isBefore(dt2)){
        context.pushReplacement(const PastFrequentScreen());
      }
      else{
        Toasty.showtoast("End Date should be greater than to Start Date");
        print("-sdoy-");
        print("DT1 is before DT2");
        print("----date---- ${dt1}${dt2}");
      }
    }

    else{
      autoValidate = AutovalidateMode.always;
    }

  }

}