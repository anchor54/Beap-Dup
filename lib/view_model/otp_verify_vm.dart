import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jpshua/constants/Toasty.dart';
import 'package:jpshua/screen/Account_num.dart';
import 'package:jpshua/screen/upload_profile_pic.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/account_vm.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:provider/provider.dart';

import '../screen/username.dart';
import '../utils/hive_utils.dart';

class OtpVM extends BaseViewModel{
  String _otpValue = "";

  String get otpValue => _otpValue;

  set otpValue(String value) {
    _otpValue = value;
  }
  late AccountVM accVM;
  @override
  initView() {
    accVM = context.read<AccountVM>();
    return super.initView();
  }

  void verifyOtp(){
    print("kkkkkkkk");
    // context.push(const UserName());
    if(otpValue.isNotEmpty && otpValue.length == 4){
    call(path: "user/verifyOtp", onSuccess: (statusCode, data) {
      Map object = jsonDecode(data);
      Toasty.showtoast(object['message']);
      HiveUtils.addSession(SessionKey.token, object['result']['resVerify']['token']);
      HiveUtils.addSession(SessionKey.name, object['result']['resVerify']['name']);
      HiveUtils.addSession(SessionKey.mobileNum, object['result']['resVerify']['mobile']);
      HiveUtils.addSession(SessionKey.dob, object['result']['resVerify']['dob']);
      HiveUtils.addSession(SessionKey.bio,  object['result']['resVerify']['bio'].toString());
      HiveUtils.addSession(SessionKey.userId,  object['result']['resVerify']['_id']);
      HiveUtils.addSession(SessionKey.user, jsonEncode(object['result']['resVerify']));
      HiveUtils.addSession(SessionKey.isLoggedIn, true);
      HiveUtils.addSession(SessionKey.goalCount,object['result']['totalActivity']);
      context.push(const UploadProfilePicture());
    },method: Method.put,params: {
      "email":accVM.gmailController.text.toString(),
      "otp":otpValue
    });
  }
    }


}