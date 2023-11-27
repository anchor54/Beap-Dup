import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/username.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/account_vm.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import 'package:jpshua/view_model/otp_verify_vm.dart';

import '../utils/appStrings.dart';
import '../view_model/dob_vm.dart';
import '../widgets/base_widget.dart';
import '../widgets/theme_button.dart';

class Otp extends BaseWidget<OtpVM>{
  const Otp({super.key});

  @override
  Widget buildUI(BuildContext context, OtpVM viewModel) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor: context.theme.primary,
          elevation: 0,
          leading:InkWell(
              onTap:(){
                context.pop();
              },
              child: Icon(Icons.arrow_back_ios,color:context.theme.onPrimary,))
      ),
      extendBody: true,
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:20,left:20,right:20,bottom:15),
                child:Align(
                  child:Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text("Confirmation",textAlign:TextAlign.center,
                          style: TextStyle(
                              fontSize:20,
                              color:context.theme.onPrimary,
                              fontWeight: FontWeight.w600)),
                      spaceY(extra:5),
                      Text("Enter the confirmation OTP code we have sent to your email.",textAlign:TextAlign.start,
                          style: TextStyle(
                              fontSize:14,
                              color:context.theme.onPrimary,
                              fontWeight: FontWeight.w500)),
                      spaceY(extra:20),
                      OtpTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        clearText:true,
                        cursorColor:context.theme.onPrimary,
                        // numberOfFields: 6,
                        numberOfFields: 4,
                        filled:true,
                        fillColor: MyColor.greyBack,
                        borderWidth: 1,
                        textStyle:TextStyle(color:context.theme.onPrimary),
                        disabledBorderColor:context.theme.onSecondary,
                        borderRadius:BorderRadius.circular(10),
                        keyboardType: TextInputType.phone,
                        // keyboardType: const TextInputType.numberWithOptions(signed: true),
                        obscureText:false,
                        fieldWidth:45,
                        // focusedBorderColor:context.theme.onPrimary,
                        // borderColor:MyColor.greyBack,
                        // enabledBorderColor:context.theme.onSecondary,
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          // otpController.otp.value=code;
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          viewModel.otpValue = verificationCode;
                        }, // end onSubmit
                      ),
                      spaceY(extra:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Did not receive the OTP code?',textScaleFactor:1,style:TextStyle(fontSize: 12,color:MyColor.onPrimary,fontWeight: FontWeight.w500)),
                          InkWell(
                            onTap:(){
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Resend',textScaleFactor:1,
                                  style:TextStyle(fontSize: 12,color:context.theme.onPrimary,fontWeight: FontWeight.w600)
                              ),
                            ),
                          )
                        ],
                      ),

                      spaceY(extra:10),


                    ],),
                )
            ),
          )
      ),
      bottomNavigationBar:  Padding(
          padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.only(bottom:60),
            child:RectangleThemeButton(onTap: () {
              viewModel.verifyOtp();
            }, text: 'Next',),
          )
      ),

    );
  }


}