import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/camera_page.dart';
import 'package:jpshua/screen/base_home.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import '../utils/appStrings.dart';
import '../view_model/upload_profile_picture_vm.dart';
import '../widgets/base_widget.dart';
import '../widgets/theme_button.dart';

class UploadProfilePicture extends BaseWidget<UploadProfilePictureVM>{
  const UploadProfilePicture({super.key});

  @override
  Widget buildUI(BuildContext context, UploadProfilePictureVM viewModel) {
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
                  padding:const EdgeInsets.only(top:20,left:15,right:15,bottom:15),
                  child:Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text("Picture",textAlign:TextAlign.center,
                          style: TextStyle(
                              fontSize:20,
                              color:context.theme.onPrimary,
                              fontWeight: FontWeight.w600)),
                      spaceY(extra:5),
                      Text("Upload a picture of yourself.\nThis is not a requirement but we recommend it.",textAlign:TextAlign.start,
                          style: TextStyle(
                              fontSize:14,
                              color:context.theme.onPrimary,
                              fontWeight: FontWeight.w500)),
                      spaceY(extra:100),
                      Align(
                        alignment:Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            viewModel.imageFile == null
                                ? CircleAvatar(
                              radius:80,
                              backgroundColor:MyColor.grey,
                              child:Padding(
                                padding:const EdgeInsets.all(12),
                                child:Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 120,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "",
                                    imageBuilder: (context, imageProvider) => Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(
                                        color: MyColor.primary,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(
                                        child:
                                        Image.asset("assets/png/profileimg.png")),
                                    errorWidget: (context, url, error) =>
                                        Image.asset("assets/png/profileimg.png"),
                                  ),
                                ),
                              )
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
                                          "Upload Profile Picture",
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
                      ),
                      spaceY(extra:10),

                    ],)
              ),
            )
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.only(bottom:60),
          child:RectangleThemeButton(onTap: () {
            viewModel.updateUserInfo();
          }, text: 'Next',),
        )
    );
  }


}