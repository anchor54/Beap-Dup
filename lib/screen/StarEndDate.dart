import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import '../utils/appStrings.dart';
import '../view_model/start_end_vm.dart';
import '../widgets/base_widget.dart';
import 'frequent.dart';

class StartEndDateScreen extends BaseWidget<StartEndDateVM>{
  const StartEndDateScreen({super.key});

  @override
  Widget buildUI(BuildContext context, StartEndDateVM viewModel) {
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
                  child:Form(
                    key:viewModel.dateKey,
                    child:Column(
                      children: [
                        Text(strTitle,
                            style: TextStyle(
                                fontSize: 30,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w700)),
                        spaceY(extra:50),
                        Text("Start Date",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:18,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:10),
                        TextFormField(
                          style:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                          textAlign:TextAlign.center,
                          inputFormatters: [viewModel.start],
                          controller:viewModel.startDateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.phone,
                          cursorColor:context.theme.onPrimary,
                          textInputAction: TextInputAction.done,
                          validator: (value){
                            if (value!.isNotEmpty) {
                              if (value.length==10) {
                                if (value=="00-00-0000"){
                                  return strInvalidStartDate;
                                }
                              }
                              else {
                                return strInvalidStartDate;
                              }
                            } else {
                              return strErrorEmptySate;
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
                        spaceY(extra:30),
                        Text("End Date",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:18,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:10),
                        TextFormField(
                          style:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                          textAlign:TextAlign.center,
                          inputFormatters: [viewModel.start],
                          keyboardType: TextInputType.phone,
                          cursorColor:context.theme.onPrimary,
                          controller:viewModel.endDateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if (value!.isNotEmpty) {
                              if (value.length==10) {
                                if (value=="00-00-0000"){
                                  return strInvalidEndDate;
                                }
                              }
                              else {
                                return strInvalidEndDate;
                              }
                            } else {
                              return strErrorEmptyEnd;
                            }
                          },
                          textInputAction: TextInputAction.done,
                          decoration:InputDecoration(
                              border: InputBorder.none,
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color:Colors.red, width: 0.0),
                              ),
                              hintText: 'MM-DD-YYYY',
                              hintStyle:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600)
                          ),
                        ),
                        spaceY(extra:10),


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
            padding: const EdgeInsets.only(bottom:50,left:150,right:150),
            child: TextButton(onPressed:(){
              viewModel.goToFromDate();
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