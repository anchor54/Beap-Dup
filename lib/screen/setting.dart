import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/login.dart';
import 'package:jpshua/screen/onboarding_screen.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/signup_vm.dart';

import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../view_model/dob_vm.dart';
import '../view_model/setting_vm.dart';
import '../widgets/base_widget.dart';
import 'Account_num.dart';
import 'edit_profile.dart';
import 'notification.dart';

class Setting extends BaseWidget<SettingVM> {
  const Setting({super.key});

  @override
  Widget buildUI(BuildContext context, SettingVM viewModel) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.primary,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: context.theme.onPrimary,
            )),
        title: Text("Settings",
            style: TextStyle(
                fontSize: 18,
                color: context.theme.onPrimary,
                fontWeight: FontWeight.w700)),
      ),
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: MyColor.greyBack,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 15),
                      child: InkWell(
                        onTap: () {
                          context.push(const EditProfile());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: viewModel.profileImg,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 30,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) => CircleAvatar(
                                    maxRadius: 30,
                                    backgroundColor: MyColor.blue,
                                    child: Text(
                                      HiveUtils.getSession<String>(
                                              SessionKey.name,
                                              defaultValue: "")
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: context.theme.primary,
                                          fontSize: 12),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    maxRadius: 30,
                                    backgroundColor: MyColor.blue,
                                    child: Text(
                                      HiveUtils.getSession<String>(
                                              SessionKey.name,
                                              defaultValue: "")
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: context.theme.primary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                spaceX(extra: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(viewModel.name.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: context.theme.onPrimary,
                                            fontWeight: FontWeight.w500)),
                                    spaceY(),
                                    Text(viewModel.userName.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: context.theme.onSecondary,
                                        )),
                                  ],
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: context.theme.onPrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ))),
              spaceY(extra: 25),
              Text("SETTING",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14,
                      color: context.theme.secondary,
                      fontWeight: FontWeight.w400)),
              spaceY(extra: 10),
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: InkWell(
                        onTap: () {
                          context.push(NotificationScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Notifications",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: context.theme.onPrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ))),
              spaceY(extra: 36),
              Text("ABOUT",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14,
                      color: context.theme.secondary,
                      fontWeight: FontWeight.w400)),
              spaceY(extra: 10),
              Container(
                  decoration: ShapeDecoration(
                    color: Color(0xFFF2F2F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: InkWell(
                        onTap: () {
                          print("h");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Share Beap",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: context.theme.onPrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ))),
              spaceY(extra: 1),
              Container(
                  decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
                  child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: InkWell(
                        onTap: () {
                          print("h");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Rate Beap",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: context.theme.onPrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ))),
              spaceY(extra: 1),
              Container(
                  decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
                  child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: InkWell(
                        onTap: () {
                          print("h");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Contact US",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: context.theme.onPrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ))),
              spaceY(extra: 1),
              Container(
                  decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
                  child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: InkWell(
                        onTap: () {
                          print("h");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("FAQ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: context.theme.onPrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ))),
              spaceY(extra: 1),
              Container(
                  decoration: ShapeDecoration(
                    color: Color(0xFFF2F2F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: InkWell(
                        onTap: () {
                          HiveUtils.addSession(SessionKey.isLoggedIn, false);
                          HiveUtils.clear();
                          context.pushAndRemoveUntil(const Onboarding());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.logout,
                              color: context.theme.onPrimary,
                              size: 20,
                            ),
                            spaceX(),
                            Text("Logout",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ))),
            ],
          ),
        ),
      )),
    );
  }
}
