import 'dart:io';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Signup.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/onboarding_screen_vm.dart';
import 'package:jpshua/widgets/base_widget.dart';

import 'login.dart';

class Onboarding extends BaseWidget<OnboardingVM>{
  const Onboarding({super.key});

  @override
  Widget buildUI(BuildContext context, OnboardingVM viewModel) {
    return Scaffold(
      appBar:AppBar(
        elevation:0,
        backgroundColor: viewModel.pageIndex==0?MyColor.colorA:viewModel.pageIndex==1?MyColor.themeBlue:viewModel.pageIndex==2?MyColor.colorB:viewModel.pageIndex==3?MyColor.colorC:viewModel.pageIndex==4?MyColor.colorD:viewModel.pageIndex==5?MyColor.colorE:MyColor.colorE,
        title:CarouselIndicator(
          count:6,
          index: viewModel.pageIndex,
          activeColor:context.theme.onBackground,
          width: Platform.isIOS?57.0:54.0,
          cornerRadius:1,
          height:2,
          color:MyColor.greyCircle,
        ),
      ),
      backgroundColor: viewModel.pageIndex==0?MyColor.colorA:viewModel.pageIndex==1?MyColor.themeBlue:viewModel.pageIndex==2?MyColor.colorB:viewModel.pageIndex==3?MyColor.colorC:viewModel.pageIndex==4?MyColor.colorD:viewModel.pageIndex==5?MyColor.colorE:MyColor.colorE,
      body: PageView(
        onPageChanged: (page){
          viewModel.pageIndex = page;
        },
        controller:viewModel.tabController,
        children: [
          Stack(
            fit:StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15,right:15,top:20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                          textAlign:TextAlign.start,
                          TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    "Welcome to Beap\n\n",
                                    style:TextStyle(
                                        fontSize: 16,
                                        color: context.theme.onBackground,letterSpacing:0.4,fontWeight:FontWeight.w400)
                                ),
                                TextSpan(
                                    text:
                                    "Customize dates,\ntimes, and reminders\n",
                                    style: TextStyle(
                                        fontSize:28,
                                        color:context.theme.onBackground,letterSpacing:0.8,height:1.3,fontWeight:FontWeight.w600)
                                ),
                              ])),
                      spaceY(extra:20),
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        // mainAxisSize:MainAxisSize.min,
                        children: [
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                },
                                child:Container(height:500,)),
                          ),
                          Expanded(
                            flex:5,
                              child: Center(child: Image.asset("assets/png/onboard.png",height:300,))),
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=1;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==0?MyColor.colorA:MyColor.themeBlue)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            fit:StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15,right:15,top:20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // spaceY(extra:80),
                      Text.rich(
                          textAlign:TextAlign.start,
                          TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    "Welcome to Beap\n\n",
                                    style:TextStyle(
                                        fontSize: 16,
                                        color: context.theme.onBackground,letterSpacing:0.4,fontWeight:FontWeight.w400)
                                ),
                                TextSpan(
                                    text:
                                    "Easily manage all\ngoals in one place \n",
                                    style: TextStyle(
                                        fontSize:28,
                                        color:context.theme.onBackground,letterSpacing:0.8,height:1.3,fontWeight:FontWeight.w600)
                                ),
                              ])),
                      spaceY(extra:20),
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        // mainAxisSize:MainAxisSize.min,
                        children: [
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=0;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==0?MyColor.colorA:MyColor.themeBlue)),
                          ),
                          Expanded(
                              flex:5,
                              child: Center(child: Image.asset("assets/png/onboard1.png",height:300,))),
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=2;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==1?MyColor.themeBlue:MyColor.colorB)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            fit:StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15,right:15,top:20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // spaceY(extra:80),
                      Text.rich(
                          textAlign:TextAlign.start,
                          TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    "Welcome to Beap\n\n",
                                    style:TextStyle(
                                        fontSize: 16,
                                        color: context.theme.onBackground,letterSpacing:0.4,fontWeight:FontWeight.w400)
                                ),
                                TextSpan(
                                    text:
                                    "Send notifications &\nreminders\n",
                                    style: TextStyle(
                                        fontSize:28,
                                        color:context.theme.onBackground,letterSpacing:0.8,height:1.3,fontWeight:FontWeight.w600)
                                ),
                              ])),
                      spaceY(extra:20),
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        // mainAxisSize:MainAxisSize.min,
                        children: [
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=1;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==1?MyColor.themeBlue:MyColor.colorB)),
                          ),
                          Expanded(
                              flex:5,
                              child: Center(child: Image.asset("assets/png/onboard2.png",height:300,))),
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=3;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==2?MyColor.colorB:MyColor.colorC)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            fit:StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15,right:15,top:20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // spaceY(extra:80),
                      Text.rich(
                          textAlign:TextAlign.start,
                          TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    "Welcome to Beap\n\n",
                                    style:TextStyle(
                                        fontSize: 16,
                                        color: context.theme.onBackground,letterSpacing:0.4,fontWeight:FontWeight.w400)
                                ),
                                TextSpan(
                                    text:
                                    "Invite your friends to\nkeep you accountable \n",
                                    style: TextStyle(
                                        fontSize:28,
                                        color:context.theme.onBackground,letterSpacing:0.8,height:1.3,fontWeight:FontWeight.w600)
                                ),
                              ])),
                      spaceY(extra:20),
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        // mainAxisSize:MainAxisSize.min,
                        children: [
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=2;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==2?MyColor.colorB:MyColor.colorC)),
                          ),
                          Expanded(
                              flex:5,
                              child: Center(child: Image.asset("assets/png/onboard3.png",height:300,))),
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=4;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==3?MyColor.colorC:MyColor.colorD)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            fit:StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15,right:15,top:20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // spaceY(extra:80),
                      Text.rich(
                          textAlign:TextAlign.start,
                          TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    "Welcome to Beap\n\n",
                                    style:TextStyle(
                                        fontSize: 16,
                                        color: context.theme.onBackground,letterSpacing:0.4,fontWeight:FontWeight.w400)
                                ),
                                TextSpan(
                                    text:
                                    "Take live pictures for\nproof \n",
                                    style: TextStyle(
                                        fontSize:28,
                                        color:context.theme.onBackground,letterSpacing:0.8,height:1.3,fontWeight:FontWeight.w600)
                                ),
                              ])),
                      spaceY(extra:20),
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        // mainAxisSize:MainAxisSize.min,
                        children: [
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=3;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==3?MyColor.colorC:MyColor.colorD)),
                          ),
                          Expanded(
                              flex:5,
                              child: Center(child: Image.asset("assets/png/onboard4.png",height:300,))),
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=4;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==4?MyColor.colorD:MyColor.colorE)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            fit:StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15,right:15,top:20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // spaceY(extra:80),
                      Text.rich(
                          textAlign:TextAlign.start,
                          TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    "Welcome to Beap\n\n",
                                    style:TextStyle(
                                        fontSize: 16,
                                        color: context.theme.onBackground,letterSpacing:0.4,fontWeight:FontWeight.w400)
                                ),
                                TextSpan(
                                    text:
                                    "Automatically track\nyour journeyproof \n",
                                    style: TextStyle(
                                        fontSize:28,
                                        color:context.theme.onBackground,letterSpacing:0.8,height:1.3,fontWeight:FontWeight.w600)
                                ),
                              ])),
                      spaceY(extra:20),
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        // mainAxisSize:MainAxisSize.min,
                        children: [
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  viewModel.pageIndex=3;
                                  viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:viewModel.pageIndex==4?MyColor.colorD:MyColor.colorE)),
                          ),
                          Expanded(
                              flex:5,
                              child: Center(child: Image.asset("assets/png/onboard5.png",height:300,))),
                          Expanded(
                            flex:1,
                            child: GestureDetector(
                                onTap:(){
                                  // viewModel.pageIndex=1;
                                  // viewModel.setPage(viewModel.pageIndex);
                                },
                                child:Container(height:500,color:MyColor.colorE)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left:15,right:15,top:15,bottom:Platform.isIOS?50:30),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start,
          mainAxisSize:MainAxisSize.max,
          children: [
            Expanded(
              child: SizedBox(
                height:45,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )
                      ),
                      backgroundColor:MaterialStateProperty.all<Color>(MyColor.onPrimary),
                    ),
                    onPressed: () {
                      context.push(const Login());
                    }, child: Text("Login",style:TextStyle(fontSize:14,color:context.theme.primary),)),
              ),
            ),
            spaceX(extra:10),
            Expanded(
              child:  SizedBox(
                height:45,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                            )
                        ),
                      backgroundColor:MaterialStateProperty.all<Color>(MyColor.primary),
                    ),
                    onPressed: () {context.push(const Signup());}, child: Text("Sign Up",style:TextStyle(fontSize:14,color:context.theme.onPrimary),)),
              ),)


          ],
        ),
      ),
    );
  }

}
