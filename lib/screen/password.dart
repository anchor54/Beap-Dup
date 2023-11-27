import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/login.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/validator.dart';
import '../utils/appStrings.dart';
import '../utils/constants.dart';
import '../view_model/dob_vm.dart';
import '../view_model/password_vm.dart';
import '../widgets/base_widget.dart';
import '../widgets/theme_button.dart';
import 'Account_num.dart';

class Password extends BaseWidget<PasswordVM>{
  const Password({super.key});

  @override
  Widget buildUI(BuildContext context, PasswordVM viewModel) {
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
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:20,left:20,right:20,bottom:15),
                child:Align(
                  child:Form(
                    key:viewModel.passwordKey,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text("Create a password",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w600)),
                        spaceY(extra:5),
                        Text("Create a password with at least 8 characters and at least 1 uppercase letter, 1 number, and 1 special character.",textAlign:TextAlign.start,
                            style: TextStyle(
                                fontSize:14,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:10),
                        TextFormField(
                          cursorColor:context.theme.onPrimary,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:viewModel.passwordController,
                          textCapitalization:TextCapitalization.sentences,
                          style:TextStyle(fontSize:18,color:MyColor.onSecondary,fontWeight:FontWeight.w500),
                          validator: (value){
                            return Validator.validateFormField(
                                value!,
                                strEmptyPassword,
                                strErrorInvalidPassword,
                                Constants.PASSWORD_VALIDATION);
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
                                    color:MyColor.onSecondary,
                                  )),
                              hintText: 'Password',
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
                              hintStyle:TextStyle(fontSize:16,color:MyColor.onSecondary,fontWeight:FontWeight.w500)
                          ),
                        ),
                        // TextFormField(
                        //   cursorColor:context.theme.onPrimary,
                        //   style:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                        //   textAlign:TextAlign.center,
                        //   textCapitalization:TextCapitalization.sentences,
                        //   autovalidateMode: AutovalidateMode.onUserInteraction,
                        //   controller:viewModel.passwordController,
                        //   keyboardType: TextInputType.visiblePassword,
                        //   textInputAction: TextInputAction.done,
                        //   validator: (value){
                        //     return Validator.validateFormField(
                        //         value!,
                        //         strEmptyPassword,
                        //         strErrorInvalidPassword,
                        //         Constants.PASSWORD_VALIDATION);
                        //   },
                        //   decoration:InputDecoration(
                        //       helperMaxLines:3,
                        //       helperText:"Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special,",
                        //       border: InputBorder.none,
                        //       errorBorder: const OutlineInputBorder(
                        //         borderSide: BorderSide(color:Colors.red, width: 0.0),
                        //       ),
                        //       hintText: 'Your Password',
                        //       hintStyle:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                        //       helperStyle:TextStyle(fontSize:12,color:MyColor.onSecondary,fontWeight:FontWeight.w600)
                        //   ),
                        // ),
                      ],
                        ),
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
              viewModel.goToDob();
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