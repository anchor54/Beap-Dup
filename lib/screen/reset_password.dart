import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/screen/back_to_login.dart';
import 'package:jpshua/screen/forgot_password.dart';
import 'package:jpshua/utils/constants.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/reset_password_vm.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../view_model/login_vm.dart';
import '../widgets/base_widget.dart';
import 'package:jpshua/utils/validator.dart';

import 'Signup.dart';

class ResetPassword extends BaseWidget<ResetPasswordVM>{
  const ResetPassword({super.key});

  @override
  Widget buildUI(BuildContext context, ResetPasswordVM viewModel) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:60,left:15,right:15,bottom:15),
                child:Align(
                  child:Form(
                    key:viewModel.resetKey,
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
                        Text("Reset Password",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:60),
                        TextFormField(
                          cursorColor:context.theme.onPrimary,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:viewModel.passwordController,
                          textCapitalization:TextCapitalization.sentences,
                          style:TextStyle(fontSize:18,color:MyColor.onSecondary,fontWeight:FontWeight.w500),
                          validator: (value) {
                            return Validator.validateFormField(
                                value!,
                                strEmptyPassword,
                                strErrorInvalidPassword,
                                Constants.NORMAL_VALIDATION);
                          },
                          obscureText: viewModel.passenable,
                          textAlign:TextAlign.start,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration:InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    //add Icon button at end of TextField
                                    if (viewModel.passenable) {
                                      //if passenable == true, make it false
                                      viewModel.passenable = false;
                                    } else {
                                      viewModel.passenable =
                                      true; //if passenable == false, make it true
                                    }
                                  },
                                  icon: Icon(
                                    viewModel.passenable == true
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye_outlined,
                                    color:context.theme.onPrimary,
                                  )),
                              hintText: 'New Password',
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              border:UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              hintStyle:TextStyle(fontSize:16,color:MyColor.onSecondary,fontWeight:FontWeight.w400)
                          ),
                        ),
                        spaceY(extra:20),
                        TextFormField(
                          cursorColor:context.theme.onPrimary,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:viewModel.confirmPasswordController,
                          textCapitalization:TextCapitalization.sentences,
                          style:TextStyle(fontSize:18,color:MyColor.onSecondary,fontWeight:FontWeight.w500),
                          validator: (value) {
                            return viewModel.passwordController.text !=
                                viewModel.confirmPasswordController.text
                                ? "Password don't match"
                                : null;
                          },
                          obscureText: viewModel.confirmPassenable,
                          textAlign:TextAlign.start,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration:InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    //add Icon button at end of TextField
                                    if (viewModel.confirmPassenable) {
                                      //if passenable == true, make it false
                                      viewModel.confirmPassenable = false;
                                    } else {
                                      viewModel.confirmPassenable =
                                      true; //if passenable == false, make it true
                                    }
                                  },
                                  icon: Icon(
                                    viewModel.confirmPassenable == true
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye_outlined,
                                    color:context.theme.onPrimary,
                                  )),
                              hintText: 'Confirm Password',
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              border:UnderlineInputBorder(borderSide: BorderSide(color: MyColor.onSecondary)),
                              hintStyle:TextStyle(fontSize:16,color:MyColor.onSecondary,fontWeight:FontWeight.w400)
                          ),
                        ),


                      ],),
                  ),
                )
            ),
          )
      ),
      bottomNavigationBar:Padding(
        padding: EdgeInsets.only(left:130,right:130,bottom: MediaQuery.of(context).viewInsets.bottom),
        child:TextButton(
          onPressed:(){
            context.push(BackToLogin());

          }, child:Text("Confirm",
            style: TextStyle(
                fontSize: 22,
                color:context.theme.onPrimary,
                fontWeight: FontWeight.w700)),),
      ),

    );
  }


}