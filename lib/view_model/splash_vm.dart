import 'package:jpshua/screen/base_home.dart';
import 'package:jpshua/screen/onboarding_screen.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/hive_utils.dart';

import '../utils/session_key.dart';
import 'base_vm.dart';

class SplashVM extends BaseViewModel{

  void checkIsLogin() async {
    Future.delayed(const Duration(seconds:1),
            (){
          if(HiveUtils.getSession<String>(SessionKey.user,defaultValue: "").isNotEmpty &&HiveUtils.getSession<bool>(SessionKey.isLoggedIn,defaultValue: false)){
            context.pushReplacement(const BaseHome());
          }else{
            context.pushReplacement(const Onboarding());
          }
        });
  }
  @override
  initView() {
    checkIsLogin();
    return super.initView();
  }
}