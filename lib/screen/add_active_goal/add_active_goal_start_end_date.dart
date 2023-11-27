import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/appStrings.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_start_end_date_vm.dart';
import 'package:jpshua/widgets/base_widget.dart';

class ActiveStartEndDateScreen extends BaseWidget<ActiveStartEndDateVM>{
  const ActiveStartEndDateScreen({super.key});

  @override
  Widget buildUI(BuildContext context, ActiveStartEndDateVM viewModel) {
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
                      key:viewModel.activeDate,
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
                            // ignore: body_might_complete_normally_nullable
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
                            inputFormatters: [viewModel.end],
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