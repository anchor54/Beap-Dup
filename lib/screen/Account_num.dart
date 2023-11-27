
import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/account_vm.dart';
import '../utils/appStrings.dart';
import '../utils/constants.dart';
import '../utils/validator.dart';
import '../widgets/base_widget.dart';
import '../widgets/theme_button.dart';

class AccountNum extends BaseWidget<AccountVM>{
  const AccountNum({super.key});

  @override
  Widget buildUI(BuildContext context, AccountVM viewModel) {
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
                  child:Form(
                    key:viewModel.gmailKey,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text("What’s your email?",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w600)),
                        spaceY(extra:5),
                        Text("Enter the email where you can be contacted. No one will see this on your profile.",textAlign:TextAlign.start,
                            style: TextStyle(
                                fontSize:14,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:viewModel.gmailController,
                          style:TextStyle(fontSize:18,color:MyColor.onSecondary,fontWeight:FontWeight.w500),
                          validator: (value){
                            return  Validator.validateFormField(
                                value!,
                                strErrorEmptyEmail,
                                strInvalidEmail,
                                Constants.EMAIL_VALIDATION);
                          },
                          textAlign:TextAlign.start,
                          cursorColor:context.theme.onPrimary,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration:InputDecoration(
                            // contentPadding: EdgeInsets.only(top:10,
                            //     left:10),
                              hintText: 'Email',
                              fillColor: MyColor.greyBack,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
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
          ),
      ),
      bottomNavigationBar:
      Padding(
        padding: EdgeInsets.only(bottom:60,),
        child: Padding(
          padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: RectangleThemeButton(onTap: () {
            viewModel.goToAcc();
          }, text: 'Next',),
        ),
      ),


    );
  }


}