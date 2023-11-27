import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/screen/join_habit.dart';
import 'package:jpshua/utils/appStrings.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import '../../view_model/add_goal_from_profile_vm/confirm_habit_profile_vm.dart';
import '../../widgets/base_widget.dart';

class ConfirmHabitProfile extends BaseWidget<ConfirmHabitProfileVM>{
  const ConfirmHabitProfile({super.key});

  @override
  Widget buildUI(BuildContext context, ConfirmHabitProfileVM viewModel) {
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
                    child:Column(
                      children: [
                        Text(strTitle,
                            style: TextStyle(
                                fontSize: 30,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w700)),
                        spaceY(extra:10),
                        Text("Confirm your Habit",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:18,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:30),
                        Container(
                            decoration:BoxDecoration(
                                color:MyColor.lightGrey,
                                borderRadius:BorderRadius.circular(10)
                            ),
                            child:Padding(
                              padding:const EdgeInsets.all(15),
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Text("Title",textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onPrimary,
                                            fontWeight: FontWeight.w500)),),
                                  Expanded(
                                    flex:4,
                                    child:Text(viewModel.titleVm.titleController.text.toString(),textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onSecondary,
                                            fontWeight: FontWeight.w500)),),



                                ],
                              ),
                            )
                        ),
                        spaceY(),
                        Container(
                            decoration:BoxDecoration(
                                color:MyColor.lightGrey,
                                borderRadius:BorderRadius.circular(10)
                            ),
                            child:Padding(
                              padding:const EdgeInsets.all(15),
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Text("Start Date",textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onPrimary,
                                            fontWeight: FontWeight.w500)),),
                                  Expanded(
                                    flex:3,
                                    child:Text(viewModel.startEndVm.startDateController.text.toString(),textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onSecondary,
                                            fontWeight: FontWeight.w500)),),



                                ],
                              ),
                            )
                        ),
                        spaceY(),
                        Container(
                            decoration:BoxDecoration(
                                color:MyColor.lightGrey,
                                borderRadius:BorderRadius.circular(10)
                            ),
                            child:Padding(
                              padding:const EdgeInsets.all(15),
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Text("End Date",textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onPrimary,
                                            fontWeight: FontWeight.w500)),),
                                  Expanded(
                                    flex:3,
                                    child:Text(viewModel.startEndVm.endDateController.text.toString(),textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onSecondary,
                                            fontWeight: FontWeight.w500)),),



                                ],
                              ),
                            )
                        ),
                        spaceY(),
                        Container(
                            decoration:BoxDecoration(
                                color:MyColor.lightGrey,
                                borderRadius:BorderRadius.circular(10)
                            ),
                            child:Padding(
                              padding:const EdgeInsets.all(15),
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Text("Every Week On",textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onPrimary,
                                            fontWeight: FontWeight.w500)),),
                                  Expanded(
                                    flex:2,
                                    child:Text(viewModel.frequentVm.selectedWeek.join(', '),textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onSecondary,
                                            fontWeight: FontWeight.w500)),),



                                ],
                              ),
                            )
                        ),
                        spaceY(),
                        Container(
                            decoration:BoxDecoration(
                                color:MyColor.lightGrey,
                                borderRadius:BorderRadius.circular(10)
                            ),
                            child:Padding(
                              padding:const EdgeInsets.all(15),
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Text("Every Day At",textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onPrimary,
                                            fontWeight: FontWeight.w500)),),
                                  Expanded(
                                    flex:2,
                                    child:Text("${viewModel.frequentVm.time}${":"}${viewModel.frequentVm.sec}${" "}${viewModel.frequentVm.duration}",textAlign:TextAlign.start,
                                        style: TextStyle(
                                            fontSize:14,
                                            color:context.theme.onSecondary,
                                            fontWeight: FontWeight.w500)),),



                                ],
                              ),
                            )
                        ),


                      ],),
                  )
              ),
            )
        ),
        bottomNavigationBar:Padding(
          padding:const EdgeInsets.only(bottom:60,left:120,right:120),
          child: TextButton(onPressed:(){
            viewModel.gotoConfirm();

          }, child:Text("Confirm",
              style: TextStyle(
                  fontSize: 22,
                  color:context.theme.onPrimary,
                  fontWeight: FontWeight.w700)),),
        )
    );
  }


}