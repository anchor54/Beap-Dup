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
import 'package:jpshua/view_model/signup_vm.dart';
import 'package:jpshua/widgets/theme_button.dart';
import '../utils/appStrings.dart';
import '../widgets/base_widget.dart';
import 'package:jpshua/utils/validator.dart';

class Signup extends BaseWidget<SignupVM>{
  const Signup({super.key});

  @override
  Widget buildUI(BuildContext context, SignupVM viewModel) {
    return Scaffold(
        extendBody: true,
        backgroundColor: context.theme.primary,
      appBar:AppBar(
          backgroundColor: context.theme.primary,
          elevation: 0,
          leading:InkWell(
              onTap:(){
                context.pop();
              },
              child: Icon(Icons.arrow_back_ios,color:context.theme.onPrimary,))
      ),
        body: SafeArea(
            child:SingleChildScrollView(
              child:Padding(
                  padding:const EdgeInsets.only(top:20,left:20,right:20,bottom:15),
                  child:Align(
                    child:Form(
                      key:viewModel.nameKey,
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Text("What’s your name?",textAlign:TextAlign.center,
                              style: TextStyle(
                                  fontSize:20,
                                  color:context.theme.onPrimary,
                                  fontWeight: FontWeight.w600)),
                          spaceY(extra:5),
                          Text("Add your name so friends can find you.",textAlign:TextAlign.center,
                              style: TextStyle(
                                  fontSize:14,
                                  color:context.theme.onPrimary,
                                  fontWeight: FontWeight.w500)),
                          spaceY(extra:10),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller:viewModel.nameController,
                            style:TextStyle(fontSize:18,color:MyColor.onSecondary,fontWeight:FontWeight.w500),
                            inputFormatters: [
                              // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                              LengthLimitingTextInputFormatter(16),
                              FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                            ],
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                            //   LengthLimitingTextInputFormatter(16),
                            // ],
                            validator: (value){
                              return  Validator.validateFormField(
                                  value!,
                                  strErrorName,
                                  strErrorInvalidUserName,
                                  Constants.NORMAL_VALIDATION);
                            },
                            textAlign:TextAlign.start,
                            cursorColor:context.theme.onPrimary,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration:InputDecoration(
                              // contentPadding: EdgeInsets.only(top:10,
                              //     left:10),
                                hintText: 'Name',
                                fillColor: MyColor.greyBack,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10) //                 <--- border radius here
                                  ),
                                  borderSide:
                                  BorderSide(color:  MyColor.onSecondary),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10) //                 <--- border radius here
                                  ),
                                  borderSide:
                                  BorderSide(color: MyColor.onSecondary),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10) //                 <--- border radius here
                                  ),
                                  borderSide:
                                  BorderSide(color: MyColor.onSecondary),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10) //                 <--- border radius here
                                  ),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                hintStyle:TextStyle(fontSize:14,color:MyColor.onSecondary,fontWeight:FontWeight.w500)
                            ),
                          ),


                        ],),
                    ),
                  )
              ),
            )
        ),
        bottomNavigationBar:
            Column(
              mainAxisSize:MainAxisSize.min,
              children: [
                Padding(
                  padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: RectangleThemeButton(onTap: () {
                    viewModel.goToSignup();
                  }, text: 'Next',),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:30,top:10),
                  child: InkWell(
                    onTap:(){
                      context.push(const Login());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Already have an account?',textScaleFactor:1,
                          style:TextStyle(fontSize: 12,color:MyColor.themeBlue,fontWeight: FontWeight.w500)
                      ),
                    ),
                  ),
                ),
              ],
            ),

    );
  }


}