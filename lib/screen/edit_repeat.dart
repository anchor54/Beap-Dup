import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/custom.dart';
import 'package:jpshua/screen/edit_custom.dart';
import 'package:jpshua/screen/create_or_edit_goal.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/repeat_vm.dart';
import 'package:jpshua/widgets/base_widget.dart';

import '../view_model/edit_repeat.dart';

class EditRepeat extends BaseWidget<EditRepeatVM> {
  const EditRepeat({super.key});

  @override
  Widget buildUI(BuildContext context, EditRepeatVM viewModel) {
    return Scaffold(
      // backgroundColor: context.theme.onPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.primary,
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: MyColor.themeBlue,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: MyColor.themeBlue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Repeat",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: context.theme.onPrimary),
                        ),
                      )
                    ],
                  ),
                  spaceY(extra: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColor.greyBack,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: viewModel.repeat.length,
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              viewModel.repeatFun(index,
                                  viewModel.repeat[index].name.toString());
                              viewModel.CreateOrEditGoalVM.updateFun(
                                  viewModel.repeat[index].name.toString());
                            },
                            child: SizedBox(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      viewModel.repeat[index].name.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: context.theme.onPrimary),
                                    ),
                                    Visibility(
                                        visible:
                                            viewModel.repeat[index].status ==
                                                    "1"
                                                ? true
                                                : false,
                                        child: Icon(
                                          Icons.check,
                                          color: MyColor.themeBlue,
                                        ))
                                  ],
                                ),
                              ),
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          color: context.theme.primary,
                          height: 2,
                        );
                      },
                    ),
                  ),
                  spaceY(extra: 20),
                  Container(
                      decoration: BoxDecoration(
                        color: MyColor.greyBack,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            viewModel.CreateOrEditGoalVM.addRepeat =
                                "Custom Repeat";
                            viewModel.CreateOrEditGoalVM.updateFun(
                                "Custom Repeat");
                            viewModel.customClick();
                            context.push(const EditCustom());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text("Custom",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: context.theme.onPrimary,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: viewModel.customClickStatus == "1"
                                    ? Icon(
                                        Icons.check,
                                        color: MyColor.themeBlue,
                                      )
                                    : Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: context.theme.onPrimary,
                                        size: 20,
                                      ),
                              )
                            ],
                          ),
                        ),
                      )),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
