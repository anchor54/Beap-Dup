import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/appStrings.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/validator.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/profile_title_vm.dart';
import 'package:jpshua/widgets/base_widget.dart';
import '../../utils/constants.dart';
import '../../utils/hive_utils.dart';
import '../../utils/session_key.dart';

class TitleProfileScreen extends BaseWidget<TitleProfileVM>{
  const TitleProfileScreen({super.key});

  @override
  Widget buildUI(BuildContext context, TitleProfileVM viewModel) {
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
              child: Icon(Icons.arrow_back,color:context.theme.onPrimary,))
      ),
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:10,left:15,right:15,bottom:15),
                child:Align(
                    child:Form(key:viewModel.profileTitles,
                      child:Column(
                        children: [
                          Text(strTitle,
                              style: TextStyle(
                                  fontSize: 30,
                                  color:context.theme.onPrimary,
                                  fontWeight: FontWeight.w700)),
                          spaceY(extra:10),
                          Text("Let’s get started, ${HiveUtils.getSession<String>(SessionKey.name, defaultValue: "")} your habit.",textAlign:TextAlign.center,
                              style: TextStyle(
                                  fontSize:18,
                                  color:context.theme.onPrimary,
                                  fontWeight: FontWeight.w500)),
                          spaceY(extra:80),
                          TextFormField(
                            textCapitalization:TextCapitalization.sentences,
                            controller:viewModel.titleController,
                            style:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                              LengthLimitingTextInputFormatter(16),
                              FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                            ],
                            validator: (value){
                              return  Validator.validateFormField(
                                  value!,
                                  strErrorTitle,
                                  strErrorInvalidUserName,
                                  Constants.NORMAL_VALIDATION);
                            },
                            textAlign:TextAlign.center,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            cursorColor:context.theme.onPrimary,
                            decoration:InputDecoration(
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color:Colors.red, width: 0.0),
                                ),
                                border: InputBorder.none,
                                hintText: 'Title',
                                hintStyle:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600)
                            ),
                          ),


                        ],),
                    )
                )
            ),
          )
      ),
      bottomNavigationBar:
      Padding(
          padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child:Padding(
            padding: const EdgeInsets.only(bottom:60,left:150,right:150),
            child:TextButton(onPressed:(){
              viewModel.goToDate();


            }, child:Text("Next",
                style: TextStyle(
                    fontSize: 22,
                    color:context.theme.onPrimary,
                    fontWeight: FontWeight.w700)),),
          )
      ),

    );
  }


}