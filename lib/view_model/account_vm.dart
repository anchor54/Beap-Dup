import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:jpshua/constants/Toasty.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/dob_vm.dart';
import 'package:jpshua/view_model/password_vm.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../screen/otp.dart';

class AccountVM extends BaseViewModel{
  var Acc = MaskTextInputFormatter(mask: '###-###-####', filter: { "#": RegExp(r'[0-9]') });
  var gmailController = TextEditingController();
  final GlobalKey<FormState> gmailKey = GlobalKey<FormState>();
  late DobVM dobVM;
  late SignupVM signupVM;
  late PasswordVM passVM;
  var _countryCode = "1";
  var _countryName = "US";
  get countryName => _countryName;

  set countryName(value) {
    _countryName = value;
  }

  get countryCode => _countryCode;

  set countryCode(value) {
    _countryCode = value;
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
    dobVM = context.read<DobVM>();
    signupVM = context.read<SignupVM>();
    passVM = context.read<PasswordVM>();
    return super.initView();
  }
  void goToAcc(){
    // context.push(const Otp());
    if(gmailKey.currentState!.validate()){
      FirebaseMessaging.instance.getToken().then((value){
        call(path: "user/resgister", onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          // Toasty.showtoast( object['result']['otp']);
          context.push(const Otp());
          // phoneController.clear();
        },method: Method.post,params: {
          "name":signupVM.nameController.text.toString(),
          "email":gmailController.text.toString(),
          "password":passVM.passwordController.text.toString(),
          "firebase":value??""
        });

      });


    }
    else{
      autoValidate = AutovalidateMode.always;
    }


  }

}