import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/screen/Account_num.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../constants/Toasty.dart';
import '../utils/appStrings.dart';

class DobVM extends BaseViewModel{
  var Dob = MaskTextInputFormatter(mask: '##-##-####', filter: { "#": RegExp(r'[0-9]') });
  var dobController = TextEditingController();
  final GlobalKey<FormState> dobKey = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  late SignupVM signupVM;
  final today = DateTime.now();
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }
  @override
  initView() {
    signupVM = context.read<SignupVM>();
    return super.initView();
  }
  // int calculateAge(DateTime birthDate) {
  //   DateTime currentDate = DateTime.now();
  //   int age = currentDate.year - birthDate.year;
  //   if (birthDate.month > currentDate.month) {
  //     age--;
  //   } else if (currentDate.month == birthDate.month) {
  //     if (birthDate.day > currentDate.day) {
  //       age--;
  //     }
  //   }
  //   return age;
  // }
  void valid(){
    DateTime dt1 =  DateFormat("MM-dd-yyyy").parse(dobController.text.toString());
    DateTime dt2 = DateFormat("MM-dd-yyyy").parse(DateTime.now().toIso8601String().substring(0,10));
    print(dt2);
    print(dt1);
    if(dt1.isAfter(dt2)){
      print("DT1 is after DT2");
      // return strInvalidDob;

    }else{
      print("jjjjj");
    }

  }
  String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }
  void goToDob(){
    if(dobKey.currentState!.validate()){
      String dobAge = calculateAge(DateFormat('MM-dd-yyyy').parse(dobController.text.toString()));
      if(int.parse(dobAge.toString())>16){
        context.push(const AccountNum());

      }else{
        Toasty.showtoast("Sorry ${signupVM.nameController.text.toString()}, you do not meet the age requirement.");

      }

    }
    else{
      autoValidate = AutovalidateMode.always;
    }


  }

}