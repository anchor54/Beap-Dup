import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/screen/back_to_login.dart';
import 'package:jpshua/screen/reset_password.dart';
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

class ForgetPassword extends BaseWidget<ForgotVM>{
  const ForgetPassword({super.key});

  @override
  Widget buildUI(BuildContext context, ForgotVM viewModel) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:60,left:15,right:15,bottom:15),
                child:Align(
                  child:Form(
                    key:viewModel.forgetKey,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: [
                        Text(strTitle,
                            style: TextStyle(
                                fontSize:40,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w700)),
                        spaceY(extra:10),
                        Text(HiveUtils.getSession<String>(SessionKey.title, defaultValue: ""),textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:30),
                        Text("Please enter the confirmation code sent to you on your registered number",
                            textScaleFactor: 1,
                            style:TextStyle(
                                fontSize: 12,
                                color: MyColor.secondary,
                                fontWeight: FontWeight.w400)),
                        spaceY(extra:60),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:viewModel.codeController,
                          textCapitalization:TextCapitalization.sentences,
                          style:TextStyle(fontSize:18,color:MyColor.onSecondary,fontWeight:FontWeight.w500),
                          validator: (value){
                            return  Validator.validateFormField(
                                value!,
                                strErrorEmptyCode,
                                strErrorInvalidCode,
                                Constants.NORMAL_VALIDATION);
                          },
                          textAlign:TextAlign.start,
                          cursorColor:context.theme.onPrimary,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration:InputDecoration(
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              border:UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              hintStyle:TextStyle(fontSize:16,color:MyColor.onSecondary,fontWeight:FontWeight.w400)
                          ),
                        ),
                        spaceY(extra:10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Didn’t recieve code?',textScaleFactor:1,style:TextStyle(fontSize: 12,color:MyColor.secondary,fontWeight: FontWeight.w400)),
                            InkWell(
                              onTap:(){
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Resend',textScaleFactor:1,
                                    style:TextStyle(fontSize: 12,color:context.theme.onPrimary,fontWeight: FontWeight.w500)
                                ),
                              ),
                            )
                          ],
                        ),


                      ],),
                  ),
                )
            ),
          )
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left:130,right:130,bottom: MediaQuery.of(context).viewInsets.bottom),
        child:TextButton(
          onPressed:(){
            HiveUtils.getSession<String>(SessionKey.title, defaultValue: "")=="Forgot Username"?context.push(const BackToLogin()):context.push(ResetPassword());
            // viewModel.goToLogin();

          }, child:Text("Continue",
            style: TextStyle(
                fontSize: 22,
                color:context.theme.onPrimary,
                fontWeight: FontWeight.w700)),),
      ),

    );
  }


}