import 'package:flutter/cupertino.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/screen/base_home.dart';
import 'package:jpshua/screen/password.dart';
import 'package:jpshua/screen/username.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';

import '../screen/signup.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class SignupVM extends BaseViewModel{
  var nameController = TextEditingController();
  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }

  void goToSignup(){
    if(nameKey.currentState!.validate()){
      // nameController.clear();
      context.push(const UserName());

    }
    else{
      autoValidate = AutovalidateMode.always;
    }

  }

}