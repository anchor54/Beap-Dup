import 'package:flutter/cupertino.dart';
import 'package:jpshua/view_model/base_vm.dart';

class ResetPasswordVM extends BaseViewModel{
  final GlobalKey<FormState> resetKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool _passenable = true;
  bool _confirmPassenable = true;
  bool get passenable => _passenable;
  bool get confirmPassenable => _confirmPassenable;

  set passenable(bool value) {
    _passenable = value;
    notifyListeners();
  }
  set confirmPassenable(bool value) {
    _confirmPassenable = value;
    notifyListeners();
  }
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }
  @override
  initView() {
    return super.initView();
  }

}