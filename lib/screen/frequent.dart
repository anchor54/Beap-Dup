import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Dob.dart';
import 'package:jpshua/screen/confirm_habit.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import '../utils/appStrings.dart';
import '../view_model/frequent_vm.dart';
import '../view_model/start_end_vm.dart';
import '../widgets/base_widget.dart';

class FrequentScreen extends BaseWidget<FrequentVM>{
  const FrequentScreen({super.key});

  @override
  Widget buildUI(BuildContext context, FrequentVM viewModel) {
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
                child:Column(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisSize:MainAxisSize.min,
                  children: [
                    Align(
                      alignment:Alignment.center,
                      child: Text(strTitle,textAlign:TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color:context.theme.onPrimary,
                            fontWeight: FontWeight.w700)),),

                    spaceY(extra:10),
                    Align(
                      alignment:Alignment.center,
                      child: Text("How frequent?",textAlign:TextAlign.start,
                          style: TextStyle(
                              fontSize:18,
                              color:context.theme.onPrimary,
                              fontWeight: FontWeight.w500)),

                    ),
                    spaceY(extra:30),
                    Text("Every Week On",textAlign:TextAlign.start,
                        style: TextStyle(
                            fontSize:18,
                            color:context.theme.onPrimary,
                            fontWeight: FontWeight.w500)),
                    spaceY(extra:10),
                    Wrap(
                      children: [
                       //for (var item in viewModel.week)
                          for(int i=0; i< viewModel.week.length; i++)
                          InkWell(
                            onTap:(){
                              if(viewModel.weekSelectStatus[i]=="1")
                                {
                                  viewModel.unselected(i);
                                }else{
                                  viewModel.selected(i);

                              }
                            },
                            child:Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                decoration:BoxDecoration(
                                    color:viewModel.weekSelectStatus[i]=="1"?context.theme.onPrimary:context.theme.primary,
                                    borderRadius:BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(viewModel.week[i],textAlign:TextAlign.center,
                                      style: TextStyle(
                                          fontSize:16,
                                          color:viewModel.weekSelectStatus[i]=="1"?context.theme.primary:context.theme.onPrimary,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          )

                      ],
                    ),
                    spaceY(extra:40),
                    Text("Every Day At",textAlign:TextAlign.center,
                        style: TextStyle(
                            fontSize:18,
                            color:context.theme.onPrimary,
                            fontWeight: FontWeight.w500)),
                    spaceY(extra:30),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Text("Time",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:16,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceX(extra:10),
                        DropdownButton<String>(
                          menuMaxHeight:150,
                          dropdownColor:context.theme.primary,
                          underline: Container(),
                          icon:Icon(Icons.keyboard_arrow_down_outlined,color:context.theme.onPrimary,),
                            style: TextStyle(
                                fontSize:18,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500),
                          value:viewModel.time,
                          items: <String>['1', '2', '3', '4','5','6','7','8','9','10','11','12']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                  style: TextStyle(
                                      fontSize:16,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            viewModel.time=newValue!;
                          },
                        ),
                        spaceX(extra:5),
                        Text(":",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:18,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w800)),
                        spaceX(extra:10),
                        DropdownButton<String>(
                          menuMaxHeight:150,
                          dropdownColor:context.theme.primary,
                          underline: Container(),
                          icon:Icon(Icons.keyboard_arrow_down_outlined,color:context.theme.onPrimary,),
                          style: TextStyle(
                              fontSize:18,
                              color:context.theme.onPrimary,
                              fontWeight: FontWeight.w500),
                          value:viewModel.sec,
                          items: <String>['1', '2', '3', '4','5','6','7','8','9','10','11','12',"13","14","15","16","17","18","19","20",
                            '21', '22', '23', '24','25','26','27','28','29','30','31','32',"33","34","35","36","37","38","39","40",
                            '41', '42', '43', '44','45','46','47','48','49','50','51','52',"53","54","55","56","57","58","59","60",
                          ]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize:16,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            viewModel.sec=newValue!;
                          },
                        ),
                        spaceX(extra:20),
                        DropdownButton<String>(
                          menuMaxHeight:150,
                          dropdownColor:context.theme.primary,
                          underline: Container(),
                          icon:Icon(Icons.keyboard_arrow_down_outlined,color:context.theme.onPrimary,),
                          style: TextStyle(
                              fontSize:18,
                              color:context.theme.onPrimary,
                              fontWeight: FontWeight.w500),
                          value:viewModel.duration,
                          items: <String>['AM', 'PM',]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize:16,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            viewModel.duration=newValue!;
                          },
                        ),


                      ],
                    )


                  ],),
            ),
          )
      ),
      bottomNavigationBar:Padding(
          padding: const EdgeInsets.only(bottom:60,left:150,right:150),
        child:TextButton(onPressed:(){
          viewModel.goToFrequent();

        }, child:Text("Next",
            style: TextStyle(
                fontSize: 22,
                color:context.theme.onPrimary,
                fontWeight: FontWeight.w700)),),
      )
    );
  }


}