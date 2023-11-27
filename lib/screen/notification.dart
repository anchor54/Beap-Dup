import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/notification_vm.dart';
import '../constants/my_theme.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../widgets/base_widget.dart';

class NotificationScreen extends BaseWidget<NotificationVM>{
  const NotificationScreen({super.key});

  @override
  Widget buildUI(BuildContext context, NotificationVM viewModel) {
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
            child: Icon(Icons.arrow_back,color:context.theme.onPrimary,)),
        centerTitle:true,
        title: Text("Notification",
            style: TextStyle(
                fontSize:18,
                color:context.theme.onPrimary,
                fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:15,left:15,right:15,bottom:15),
                child:Column(
                  mainAxisSize:MainAxisSize.max,
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration:BoxDecoration(
                            color:MyColor.lightGrey,
                            borderRadius:BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding:const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding:EdgeInsets.only(left:8),child:Text("Reminders",textAlign:TextAlign.center,
                                  style: TextStyle(
                                      fontSize:14,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),),
                              Padding(padding: EdgeInsets.all(5),
                                child: FlutterSwitch(
                                  height:30,
                                  width:60,
                                  value:viewModel.isSwitched,
                                  onToggle:viewModel.toggleSwitch,
                                  activeToggleColor:context.theme.primary,
                                  inactiveToggleColor:MyColor.green,
                                  activeColor:MyColor.green,
                                  inactiveColor:context.theme.primary,

                                ),

                              )

                            ],
                          ),
                        )
                    ),
                    spaceY(),
                    Padding(padding:const EdgeInsets.only(left:5),
                      child: Text("Sydney reminded you to Workout ",textAlign:TextAlign.start,
                          style: TextStyle(
                              fontSize:12,
                              color:context.theme.secondary,
                              fontWeight: FontWeight.w400)),),
                    spaceY(extra:15),
                    Container(
                        decoration:BoxDecoration(
                            color:MyColor.lightGrey,
                            borderRadius:BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding:const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding:EdgeInsets.only(left:8),child:Text("Friend Request",textAlign:TextAlign.center,
                                  style: TextStyle(
                                      fontSize:14,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),),
                              Padding(padding: EdgeInsets.all(5),
                                child: FlutterSwitch(
                                  height:30,
                                  width:60,
                                  value:viewModel.isSwitchedFrd,
                                  onToggle:viewModel.toggleSwitchFrd,
                                  activeToggleColor:context.theme.primary,
                                  inactiveToggleColor:MyColor.green,
                                  activeColor:MyColor.green,
                                  inactiveColor:context.theme.primary,

                                ),

                              )

                            ],
                          ),
                        )
                    ),
                    spaceY(),
                    Padding(padding:const EdgeInsets.only(left:5),
                      child: Text("Alexis just sent you a friend request ",textAlign:TextAlign.start,
                          style: TextStyle(
                              fontSize:12,
                              color:context.theme.secondary,
                              fontWeight: FontWeight.w400)),),
                    spaceY(extra:15),
                    Container(
                        decoration:BoxDecoration(
                            color:MyColor.lightGrey,
                            borderRadius:BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding:const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding:EdgeInsets.only(left:8),child:Text("Late Habits",textAlign:TextAlign.center,
                                  style: TextStyle(
                                      fontSize:14,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),),
                              Padding(padding: EdgeInsets.all(5),
                                child: FlutterSwitch(
                                  height:30,
                                  width:60,
                                  value:viewModel.isSwitchedHabit,
                                  onToggle:viewModel.toggleSwitchHabit,
                                  activeToggleColor:context.theme.primary,
                                  inactiveToggleColor:MyColor.green,
                                  activeColor:MyColor.green,
                                  inactiveColor:context.theme.primary,

                                ),

                              )

                              // Switch(
                              //   onChanged:viewModel.toggleSwitchHabit,
                              //   value:viewModel.isSwitchedHabit,
                              //   activeColor:context.theme.primary,
                              //   activeTrackColor:MyColor.green,
                              //   inactiveThumbColor: MyColor.green,inactiveTrackColor:context.theme.primary,
                              // ),

                            ],
                          ),
                        )
                    ),
                    spaceY(),
                    Padding(padding:const EdgeInsets.only(left:5),
                      child: Text("You’re late for your workout",textAlign:TextAlign.start,
                          style: TextStyle(
                              fontSize:12,
                              color:context.theme.secondary,
                              fontWeight: FontWeight.w400)),),
                    spaceY(extra:15),


                  ],),
            ),
          )
      ),
      bottomNavigationBar:Padding(
          padding:Platform.isIOS?const EdgeInsets.only(bottom:30):const EdgeInsets.only(bottom:20),
          child: Text("Habits.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}",textAlign:TextAlign.center,
              style: TextStyle(
                  fontSize:14,
                  color:context.theme.onPrimary,
                  fontWeight: FontWeight.w500))),
    );
  }


}