import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import '../view_model/edit_profile_vm.dart';
import '../widgets/base_widget.dart';

class EditProfile extends BaseWidget<EditProfileVM>{
  const EditProfile({super.key});

  @override
  Widget buildUI(BuildContext context, EditProfileVM viewModel) {
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
          title: Text("Edit Profile",
              style: TextStyle(
                  fontSize:18,
                  color:context.theme.onPrimary,
                  fontWeight: FontWeight.w700)),
        ),
        body:SafeArea(
            child:SingleChildScrollView(
              child:Padding(
                  padding:const EdgeInsets.only(top:15,left:15,right:15,bottom:15),
                  child:Align(
                    child:Column(
                      mainAxisSize:MainAxisSize.max,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            viewModel.imageFile == null
                                ? CachedNetworkImage(
                              imageUrl:viewModel.profileImg,
                              imageBuilder: (context,
                                  imageProvider) =>
                                  CircleAvatar(
                                    radius:80,
                                    backgroundImage: imageProvider,
                                  ),
                              placeholder: (context, url) =>CircleAvatar(
                          maxRadius:80,
                          backgroundColor:MyColor.blue,
                          child: Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:42),),
                        ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                    maxRadius:80,
                                    backgroundColor:MyColor.blue,
                                    child: Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:42,),),
                        ),
                    )
                                :CircleAvatar(
                              radius:80,
                              backgroundColor:MyColor.grey,
                              child: Padding(padding:const EdgeInsets.all(12),child:CircleAvatar(
                                radius: 60.0,
                                backgroundImage: Image.file(
                                  viewModel.imageFile!,
                                  fit: BoxFit.contain,
                                ).image,
                              ), ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                      context: context, builder: (context) =>
                                        CupertinoActionSheet(title: Text(
                                          "Change Profile Picture",
                                          style: TextStyle(fontSize:16,color:context.theme.primary),
                                        ),
                                          message: Text(
                                            "Your Profile Picture will be visible to everyone and it will make it easier for your friends to add you ",
                                            style: TextStyle(fontSize: 12.0,color:context.theme.primary),
                                          ),
                                          actions: <Widget>[
                                            CupertinoActionSheetAction(
                                              isDefaultAction: true,
                                              onPressed: () {
                                                context.pop();
                                                viewModel.getImgGallery();
                                              },
                                              child: Text("Photo Library",style:TextStyle(color:MyColor.lightBlue),),
                                            ),
                                          ],
                                          cancelButton: CupertinoActionSheetAction(
                                            child: Text("Cancel",style:TextStyle(color:MyColor.lightBlue),),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height:40,
                                    width: 40,
                                    decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:context.theme.primary,
                                        border:Border.all(color:context.theme.onPrimary)
                                    ),
                                    child: Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color:context.theme.onPrimary,
                                        )),
                                  ),
                                )),
                          ],
                        ),
                        spaceY(extra:10),
                        Text(viewModel.name.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color:context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceY(),
                        Text(viewModel.userName.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color:context.theme.onSecondary,
                            )),

                        spaceY(extra:15),
                        Row(
                          mainAxisSize:MainAxisSize.min,
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            Expanded(flex:1,
                              child:Text("Full Name",textAlign:TextAlign.start,
                                  style: TextStyle(
                                      fontSize:14,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),),
                            Expanded(flex:2,
                              child:TextFormField(
                                controller:viewModel.nameController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                cursorColor:context.theme.onPrimary,
                                textCapitalization:TextCapitalization.sentences,
                                onFieldSubmitted: (newValue) {
                                  viewModel.updateFullName();
                                },
                                onChanged: (value) {
                                  viewModel.nameController.value = TextEditingValue(
                                      text: value.toString(),
                                      selection: viewModel.nameController.selection);
                                },

                                style:TextStyle(fontSize:14,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                                  LengthLimitingTextInputFormatter(16),
                                ],
                                textAlign:TextAlign.start,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration:InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '[Name]',
                                    hintStyle:TextStyle(fontSize:14,color:MyColor.onSecondary,fontWeight:FontWeight.w600)
                                ),
                              ),)

                          ],
                        ),
                        Container(height:1,color:context.theme.onSecondary,),
                        Row(
                          mainAxisSize:MainAxisSize.min,
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            Expanded(flex:1,
                              child:Text("User Name",textAlign:TextAlign.start,
                                  style: TextStyle(
                                      fontSize:14,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),),
                            Expanded(flex:2,
                              child:TextFormField(
                                key:viewModel.formKey,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller:viewModel.usernameController,
                                validator: (value) => !viewModel.isValidUserName ? viewModel.message:null,
                                onFieldSubmitted: (newValue) {
                                  viewModel.goCheckUserName();
                                },
                                onChanged: (value) {
                                  viewModel.usernameController.value = TextEditingValue(
                                      text: value,
                                      selection: viewModel.usernameController.selection);
                                },
                                // textCapitalization:TextCapitalization.characters,
                                // validator: (value){
                                //   return  Validator.validateFormField(
                                //       value!,
                                //       strErrorEmptyUserName,
                                //       strErrorInvalidUserName,
                                //       Constants.MIN_CHAR_VALIDATION);
                                // },
                                inputFormatters: <TextInputFormatter>[
                                  // FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9_]")),
                                  LengthLimitingTextInputFormatter(16),
                                ],
                                cursorColor:context.theme.onPrimary,
                                style:TextStyle(fontSize:14,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                                textAlign:TextAlign.start,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration:InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'User Name',
                                    hintStyle:TextStyle(fontSize:14,color:MyColor.onSecondary,fontWeight:FontWeight.w600)
                                ),
                              ),)

                          ],
                        ),
                        Container(height:1,color:context.theme.onSecondary,),
                        Row(
                          mainAxisSize:MainAxisSize.min,
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            Expanded(flex:1,
                              child:Text("Bio",textAlign:TextAlign.start,
                                  style: TextStyle(
                                      fontSize:14,
                                      color:context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),),
                            Expanded(flex:2,
                              child:TextFormField(
                                onFieldSubmitted: (newValue) {
                                  viewModel.updateBio();
                                },
                                onChanged: (value) {
                                  viewModel.bioController.value = TextEditingValue(
                                      text: value,
                                      selection: viewModel.bioController.selection);
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller:viewModel.bioController,
                                cursorColor:context.theme.onPrimary,
                                textCapitalization:TextCapitalization.sentences,
                                style:TextStyle(fontSize:14,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
                                textAlign:TextAlign.start,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration:InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Bio',
                                    hintStyle:TextStyle(fontSize:14,color:MyColor.onSecondary,fontWeight:FontWeight.w600)
                                ),
                              ),)

                          ],
                        ),
                        // spaceY(extra:100),
                        //
                        // TextButton(onPressed:(){
                        //   viewModel.updateUserInfo();
                        // }, child:Text("Update",
                        //     style: TextStyle(
                        //         fontSize:18,
                        //         color:context.theme.onPrimary,
                        //         fontWeight: FontWeight.w700)),),


                      ],)
                  )
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