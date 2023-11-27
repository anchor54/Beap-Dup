import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/screen/add_goal_from_profile/frequent_profile.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../constants/Toasty.dart';

class StartEndDateProfileVM extends BaseViewModel{
  var start = MaskTextInputFormatter(mask: '##-##-####', filter: { "#": RegExp(r'[0-9]') });
  var end = MaskTextInputFormatter(mask: '##-##-####', filter: { "#": RegExp(r'[0-9]') });
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  GlobalKey<FormState> profiledateKey = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }
  @override
  initView() {
    profiledateKey=GlobalKey<FormState>();
    return super.initView();
  }
  void goToFromDate(){
    if(profiledateKey.currentState!.validate()){
      DateTime dt1 =  DateFormat('MM-dd-yyyy').parse(startDateController.text.toString());
      DateTime dt2 = DateFormat('MM-dd-yyyy').parse(endDateController.text.toString());
      if(dt1.isBefore(dt2)){
        context.pushReplacement(const FrequentProfileScreen());
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