import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/username_vm.dart';
import '../utils/appStrings.dart';
import '../widgets/base_widget.dart';
import '../widgets/theme_button.dart';

class UserName extends BaseWidget<UserNameVM>{
  const UserName({super.key});

  @override
  Widget buildUI(BuildContext context, UserNameVM viewModel) {
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
              child: Icon(Icons.arrow_back_ios,color:context.theme.onPrimary,))
      ),
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:20,left:20,right:20,bottom:15),
                child:Align(
                  child:Form(
                    key:viewModel.userKey,
                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text("Create a username",textAlign:TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w600)),
                        spaceY(extra:5),
                        Text("Create a username or use our suggestion. You can change this at any time.",textAlign:TextAlign.start,
                            style: TextStyle(
                                fontSize:14,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(extra:10),

                        TextFormField(
                          cursorColor:context.theme.onPrimary,
                          autovalidateMode:viewModel.autoValidate,
                          controller:viewModel.usernameController,
                          inputFormatters: <TextInputFormatter>[
                            // FilteringTextInputFormatter.allow(RegExp("[a-z0-9_]")),
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9_]")),
                            LengthLimitingTextInputFormatter(16),
                          ],
                          validator: (value){
                            print("-------------${viewModel.isValidUserName}");
                             if(!viewModel.isValidUserName){
                              return viewModel.message;

                            }

                          },
                          onFieldSubmitted: (newValue) {
                            viewModel.goCheckUserName();
                          },
                          onChanged: (value) {
                            viewModel.isValidUserName=true;
                            viewModel.message="";
                            viewModel.usernameController.value = TextEditingValue(
                                text: value,
                                selection: viewModel.usernameController.selection);
                          },
                          style:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                          textAlign:TextAlign.start,
                          decoration:InputDecoration(
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
                              hintText: 'Username',
                              hintStyle:TextStyle(fontSize:14,color:MyColor.onSecondary,fontWeight:FontWeight.w500)
                          ),
                        ),


                      ],),
                  )
                )
            ),
          )
      ),
      bottomNavigationBar: Padding(
          padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child:Padding(
            padding: const EdgeInsets.only(bottom:60),
            child:RectangleThemeButton(onTap: () {
              viewModel.goToRegister();
            }, text: 'Next',),
          )
      ),

    );
  }


}