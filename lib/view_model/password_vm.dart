import 'package:flutter/cupertino.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import 'package:provider/provider.dart';
import '../screen/Account_num.dart';
import 'base_vm.dart';

class PasswordVM extends BaseViewModel{
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  bool _passenable = true;
  bool get passenable => _passenable;

  set passenable(bool value) {
    _passenable = value;
    notifyListeners();
  }
  late SignupVM signupVM;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }
  @override
  initView() {
    signupVM = context.read<SignupVM>();
    return super.initView();
  }
  void goToDob(){
    if(passwordKey.currentState!.validate()){
      // dobController.clear();
      // context.push(const Dob());
      context.push(const AccountNum());

    }
    else{
      autoValidate = AutovalidateMode.always;
    }


  }

}