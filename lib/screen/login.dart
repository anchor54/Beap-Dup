import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/Toasty.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/screen/forgot_password.dart';
import 'package:jpshua/utils/constants.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../view_model/login_vm.dart';
import '../widgets/base_widget.dart';
import 'package:jpshua/utils/validator.dart';
import '../widgets/theme_button.dart';
import 'Signup.dart';

class Login extends BaseWidget<LoginVM> {
  const Login({super.key});

  @override
  Widget buildUI(BuildContext context, LoginVM viewModel) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.theme.primary,
      appBar: AppBar(
          backgroundColor: context.theme.primary,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: context.theme.onPrimary,
              ))),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
            child: Align(
              child: Form(
                key: viewModel.loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Log in to Beap",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: context.theme.onPrimary,
                            fontWeight: FontWeight.w600)),
                    spaceY(extra: 60),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: viewModel.usernameController,
                      style: TextStyle(
                          fontSize: 18,
                          color: MyColor.onSecondary,
                          fontWeight: FontWeight.w500),
                      validator: (value) {
                        return Validator.validateFormField(
                            value!,
                            strErrorEmptyUserName,
                            strErrorInvalidUserName,
                            Constants.NORMAL_VALIDATION);
                      },
                      inputFormatters: <TextInputFormatter>[
                        // FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                        // FilteringTextInputFormatter.allow(RegExp("[a-z0-9_]")),
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z0-9_]")),
                        LengthLimitingTextInputFormatter(16),
                      ],
                      textAlign: TextAlign.start,
                      cursorColor: context.theme.onPrimary,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.only(top:10,
                          //     left:10),
                          hintText: 'Username/Email',
                          fillColor: MyColor.greyBack,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    10) //                 <--- border radius here
                                ),
                            borderSide: BorderSide(color: MyColor.onSecondary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    10) //                 <--- border radius here
                                ),
                            borderSide: BorderSide(color: MyColor.onSecondary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    10) //                 <--- border radius here
                                ),
                            borderSide: BorderSide(color: MyColor.onSecondary),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10) //                 <--- border radius here
                                ),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: MyColor.onSecondary,
                              fontWeight: FontWeight.w500)),
                    ),
                    // Align(
                    //   alignment:Alignment.topRight,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 10),
                    //     child: InkWell(
                    //       onTap: () {
                    //         HiveUtils.addSession(SessionKey.title,"Forgot Username");
                    //         context.push(const ForgetPassword());
                    //       },
                    //       child: Text("Forgot Username?",
                    //           textScaleFactor: 1,
                    //           style:TextStyle(
                    //               fontSize: 12,
                    //               color: MyColor.secondary,
                    //               fontWeight: FontWeight.w400)),
                    //     ),
                    //   ),
                    // ),
                    spaceY(extra: 20),
                    TextFormField(
                      cursorColor: context.theme.onPrimary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: viewModel.passwordController,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          fontSize: 18,
                          color: MyColor.onSecondary,
                          fontWeight: FontWeight.w500),
                      validator: (value) {
                        return Validator.validateFormField(
                            value!,
                            strEmptyPassword,
                            strErrorInvalidPassword,
                            Constants.PASSWORD_VALIDATION);
                      },
                      obscureText: viewModel.passenable,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
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
                                color: MyColor.onSecondary,
                              )),
                          hintText: 'Password',
                          fillColor: MyColor.greyBack,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    10) //                 <--- border radius here
                                ),
                            borderSide: BorderSide(color: MyColor.onSecondary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    10) //                 <--- border radius here
                                ),
                            borderSide: BorderSide(color: MyColor.onSecondary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    10) //                 <--- border radius here
                                ),
                            borderSide: BorderSide(color: MyColor.onSecondary),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10) //                 <--- border radius here
                                ),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: MyColor.onSecondary,
                              fontWeight: FontWeight.w500)),
                    ),
                    // Align(
                    //   alignment:Alignment.topRight,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 10),
                    //     child: InkWell(
                    //       onTap: () {
                    //         // HiveUtils.addSession(SessionKey.title,"Forgot Password");
                    //         // context.push(const ForgetPassword());
                    //       },
                    //       child: Text("Forget password?",
                    //           textScaleFactor: 1,
                    //           style:TextStyle(
                    //               fontSize: 13,
                    //               color: MyColor.themeBlue,
                    //               fontWeight: FontWeight.w500)),
                    //     ),
                    //   ),
                    // ),
                    // spaceY(extra:10),
                    // Row(
                    //   children: <Widget>[
                    //     Theme(
                    //       data: ThemeData(
                    //           unselectedWidgetColor:context.theme.background),
                    //       child: Checkbox(
                    //         value: viewModel.rememberMe,
                    //         checkColor: context.theme.primary,
                    //         activeColor: context.theme.onPrimary,
                    //         onChanged: (value) {
                    //           viewModel.rememberMe = value!;
                    //         },
                    //       ),
                    //     ),
                    //     Text('Keep me logged in',
                    //         textScaleFactor: 1,
                    //         style:TextStyle(
                    //             fontSize:12,
                    //             color: context.theme.onPrimary,
                    //             fontWeight: FontWeight.w400,
                    //             letterSpacing: 0.2,
                    //             height: 1.2)),
                    //   ],
                    // ),
                  ],
                ),
              ),
            )),
      )),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: RectangleThemeButton(
                onTap: () {
                  print("Trying to login");
                  viewModel.goToLogin();
                },
                text: 'Login',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
