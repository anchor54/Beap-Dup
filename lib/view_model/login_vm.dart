import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:jpshua/screen/base_home.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/base_vm.dart';

import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class LoginVM extends BaseViewModel {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _passenable = true;
  bool get passenable => _passenable;

  set passenable(bool value) {
    _passenable = value;
    notifyListeners();
  }

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }

  void goToLogin() {
    if (loginKey.currentState!.validate()) {
      FirebaseMessaging.instance.getToken().then((value) {
        // print('login $value');
        call(
            path: "user/login",
            isShowLoader: false,
            onSuccess: (statusCode, data) {
              Map object = jsonDecode(data);
              // Toasty.showtoast(object['message']);
              HiveUtils.addSession(
                  SessionKey.token, object['result']['update']['token']);
              HiveUtils.addSession(
                  SessionKey.user, jsonEncode(object['result']['update']));
              HiveUtils.addSession(
                  SessionKey.name, object['result']['update']['name']);
              HiveUtils.addSession(
                  SessionKey.bio, object['result']['update']['bio'].toString());
              HiveUtils.addSession(
                  SessionKey.mobileNum, object['result']['update']['mobile']);
              HiveUtils.addSession(
                  SessionKey.dob, object['result']['update']['dob']);
              HiveUtils.addSession(
                  SessionKey.userName, object['result']['update']['userName']);
              HiveUtils.addSession(
                  SessionKey.userId, object['result']['update']['_id']);
              HiveUtils.addSession(SessionKey.image,
                  object['result']['update']['image'].toString());
              HiveUtils.addSession(SessionKey.isLoggedIn, true);
              HiveUtils.addSession(
                  SessionKey.goalCount, object['result']['totalActivity']);
              context.pushReplacement(const BaseHome());
              usernameController.text = "";
              passwordController.text = "";
            },
            method: Method.post,
            params: {
              "userName": usernameController.text.toString(),
              "password": passwordController.text.toString(),
              "firebase": value ?? ''
            });
      }).catchError((error) {
        print('login $error');
      });
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }
}
