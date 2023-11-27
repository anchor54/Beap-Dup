import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/constants/Toasty.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/validator.dart';
import 'package:jpshua/view_model/signup_vm.dart';

import '../utils/appStrings.dart';
import '../utils/constants.dart';
import '../view_model/dob_vm.dart';
import '../widgets/base_widget.dart';
import 'Account_num.dart';

class Dob extends BaseWidget<DobVM>{
  const Dob({super.key});

  @override
  Widget buildUI(BuildContext context, DobVM viewModel) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor: context.theme.primary,
          elevation: 0,
          leading:InkWell(
              onTap:(){
                context.pop();
              },
              child: Icon(Icons.arrow_back,color:context.theme.onPrimary,))
      ),
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:10,left:15,right:15,bottom:15),
                child:Align(
                  child:Form(
                    key:viewModel.dobKey,
                    child: Column(
                      children: [
                        Text(strTitle,
                            style: TextStyle(
                                fontSize: 30,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w700)),
                        spaceY(extra:10),
                        Text("Hi ${viewModel.signupVM.nameController.text.toString()}, when’s your birthday?",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:18,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:80),
                        TextFormField(
                          style:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                          textAlign:TextAlign.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:viewModel.dobController,
                          inputFormatters: [viewModel.Dob],
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (newValue){

                          },
                          cursorColor:context.theme.onPrimary,
                          validator: (value){
                            print("--------dob----$value");
                            String formattedDate = DateFormat('MM-dd-yyyy').format(viewModel.today);
                            print("--------today----${formattedDate}");
                            if (value!.isNotEmpty) {
                              if (value.length==10) {
                                if (value=="00-00-0000"){
                                  return strInvalidDob;
                                }
                                else if(value.toString()==formattedDate){
                                  return strInvalidDob;

                                }
                              }
                              else {
                                return strInvalidDob;
                              }
                            } else {
                              return strErrorEmptyDob;
                            }
                          },
                          decoration:InputDecoration(
                              border: InputBorder.none,
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color:Colors.red, width: 0.0),
                              ),
                              hintText: 'MM-DD-YYYY',
                              hintStyle:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600)
                          ),
                        ),


                      ],),
                  ),
                )
            ),
          )
      ),
      bottomNavigationBar:
      Padding(
          padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding:const EdgeInsets.only(bottom:60),
            child:  Column(
              mainAxisSize:MainAxisSize.min,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Padding(padding:const EdgeInsets.only(left:10,right:10),
                  child:Text("Only to make sure you’re old enough to use Habits",textAlign:TextAlign.center,
                      style: TextStyle(
                          fontSize:16,
                          color:context.theme.onPrimary,
                          fontWeight: FontWeight.w500)),
                ),

                spaceY(extra:20),
                TextButton(
                  onPressed:(){
                    viewModel.goToDob();
                  },
                  child:Text("Next",
                      style: TextStyle(
                          fontSize: 22,
                          color:context.theme.onPrimary,
                          fontWeight: FontWeight.w700)),)

              ],
            ),
          )
      ),

    );
  }


}