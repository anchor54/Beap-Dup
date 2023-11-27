import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/my_theme.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../view_model/camera_preview_vm.dart';
import '../widgets/base_widget.dart';

class PreviewPage extends BaseWidget<CameraPreviewVM> {
  const PreviewPage({super.key, required this.picture});

  final XFile picture;

  @override
  Widget buildUI(BuildContext context, CameraPreviewVM viewModel) {
    return Scaffold(
      backgroundColor: context.theme.onPrimary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(strTitle,
              style: TextStyle(
                  fontSize: 28,
                  color: context.theme.primary,
                  fontWeight: FontWeight.w700)),
          leading: InkWell(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.clear,
                color: context.theme.primary,
              ))),
      body: Stack(
        children: [
          Image.file(
            File(picture.path),
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: Platform.isIOS
                    ? EdgeInsets.only(left: 10, right: 10, bottom: 40)
                    : const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: context.theme.primary,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              // <-- SEE HERE
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Select a habit",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      context.theme.onPrimary,
                                                  fontWeight: FontWeight.w700)),
                                          InkWell(
                                            onTap: () {
                                              context.pop();
                                            },
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor:
                                                  context.theme.onSecondary,
                                              child: Icon(
                                                Icons.close,
                                                color: context.theme.onPrimary,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    spaceY(extra: 15),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: viewModel.activeGoal.length,
                                        primary: true,
                                        physics: const ScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                viewModel.selectedValue =
                                                    viewModel.activeGoal[index]
                                                        .habitTitle
                                                        .toString();
                                                HiveUtils.addSession(
                                                    SessionKey.activityId,
                                                    viewModel
                                                        .activeGoal[index].sId
                                                        .toString());
                                                context.pop();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 8,
                                                    right: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        viewModel
                                                            .activeGoal[index]
                                                            .habitTitle
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: context.theme
                                                                .onPrimary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                              ));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: MyColor.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(viewModel.selectedValue,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500)),
                          )),
                    )),
                    spaceX(extra: 10),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        viewModel.filePath = picture.path;
                        viewModel.uploadDailyTask();
                        // Share.share(viewModel.selectedValue);
                      },
                      child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: MyColor.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Send",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.theme.onPrimary,
                                      fontWeight: FontWeight.w500)),
                              spaceX(extra: 10),
                              Icon(
                                Icons.send,
                                color: context.theme.onPrimary,
                                size: 15,
                              ),
                            ],
                          ))),
                    ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
