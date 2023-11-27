import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jpshua/screen/password.dart';
import 'package:jpshua/screen/upload_profile_pic.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';

import '../constants/Toasty.dart';

class UserNameVM extends BaseViewModel{
  bool _isValidUserName = false;
  String message="",isStatus="";
  var usernameController = TextEditingController();
  final GlobalKey<FormState> userKey = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }


  bool get isValidUserName => _isValidUserName;

  set isValidUserName(bool value) {
    _isValidUserName = value;
    notifyListeners();
  }
  void goToRegister() {
    _isValidUserName = true;
    FocusScope.of(context).unfocus();
    userKey.currentState!.save();
    goCheckUserName();

  }
  void goCheckUserName() {
    // context.push(const UploadProfilePicture());
    if(usernameController.text.isNotEmpty){
      autoValidate = AutovalidateMode.onUserInteraction;
      print("-----------${autoValidate}");
      call(path: "user/checkUserName",
        queryParameters:{
        'userName':usernameController.text.toString(),
        },
        onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        isStatus=object["isStatus"].toString();
        isValidUserName = object["isStatus"] == 1;
        if(!isValidUserName){
          print(isValidUserName);
          print("----if-----");
          message=object["message"].toString();
          notifyListeners();
        }else{
          print("--else----");
          message =object["message"].toString();
          notifyListeners();
        }
        print("-----------isValidUserName------${isValidUserName}");
        if(message=="Verifed"){
          isValidUserName=true;
          notifyListeners();
          context.push(const Password());
        }
        // message.isEmpty?Toasty.showtoast("Please Verify Username"): Toasty.showtoast(message);
        // callRegister();
      },method: Method.post,);
    }else{
      autoValidate = AutovalidateMode.always;
      // Toasty.showtoast("Enter User Name");
    }
  }

}