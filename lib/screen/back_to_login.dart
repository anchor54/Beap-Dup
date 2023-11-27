import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/screen/login.dart';
import 'package:jpshua/utils/constants.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/view_model/forgot_password_vm.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import '../utils/appStrings.dart';
import '../utils/session_key.dart';
import '../view_model/login_vm.dart';
import '../widgets/base_widget.dart';
import 'package:jpshua/utils/validator.dart';

class BackToLogin extends BaseWidget<ForgotVM>{
  const BackToLogin({super.key});

  @override
  Widget buildUI(BuildContext context, ForgotVM viewModel) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child:Padding(
              padding:const EdgeInsets.only(top:15,left:15,right:15,bottom:15),
              child:Center(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    Text(HiveUtils.getSession<String>(SessionKey.title, defaultValue: "")=="Forgot Username"?"Your User Name has been sent to your registered number via SMS":"Your Password has been changed!",
                        textScaleFactor: 1,textAlign:TextAlign.center,
                        style:TextStyle(
                            fontSize: 16,
                            color: MyColor.secondary,
                            fontWeight: FontWeight.w400)),
                    spaceY(extra:30),
                    InkWell(
                      onTap:(){
                        context.push(const Login());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Back to Login',textScaleFactor:1,
                            style:TextStyle(fontSize:18,color:context.theme.onPrimary,fontWeight: FontWeight.w500)
                        ),
                      ),
                    )


                  ],),
              )
          )
      ),

    );
  }


}