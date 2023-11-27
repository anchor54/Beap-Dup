import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/components/GoalItem.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/model/goal_model.dart';
import 'package:jpshua/screen/add_active_goal/add_active_goal_title.dart';
import 'package:jpshua/screen/otp.dart';
import 'package:jpshua/screen/past_goal_summary.dart';
import 'package:jpshua/screen/title.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/widgets/atom/actionable_container.dart';
import '../view_model/all_goal_vm.dart';
import '../widgets/base_widget.dart';
import 'create_or_edit_goal.dart';

class AllActiveGoals extends StatelessWidget {
  const AllActiveGoals(
      {super.key, this.editable = true, this.goals = const []});
  final bool editable;
  final List<GoalModel> goals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.primary,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: context.theme.onPrimary,
            )),
        title: Text("All Active Goals",
            style: TextStyle(
                fontSize: 18,
                color: context.theme.onPrimary,
                fontWeight: FontWeight.w700)),
      ),
      extendBody: true,
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (editable)
                ActionableContainer(
                    child: InkWell(
                  onTap: () {
                    context.push(const CreateOrEditGoal());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add New Goal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: context.theme.onPrimary,
                              fontWeight: FontWeight.w500)),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: context.theme.onPrimary),
                    ],
                  ),
                )),
              if (editable)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Add more goals to your current list",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12,
                          color: context.theme.secondary,
                          fontWeight: FontWeight.w400)),
                ),
              if (editable) spaceY(extra: 15),
              goals.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemCount: goals.length,
                      primary: true,
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GoalItem(
                          key: new Key(goals[index].sId ?? ""),
                          slidable: false,
                          goalTitle: goals[index].habitTitle.toString(),
                          visibility: goals[index].visibility,
                          frequency: goals[index].repeat!.type.toString() ==
                                  "Custom Repeat"
                              ? "${"Every"}${" "}${goals[index].repeat!.every!.type.toString()}${" "}${goals[index].repeat!.every!.frequency.toString()}"
                              : goals[index].repeat!.type.toString(),
                          skinGame: goals[index].skinGame,
                          onTap: () {
                            HiveUtils.addSession(SessionKey.activityId, goals[index].sId);
                            context.push(const GoalSummary(title: "Summary"));
                          },
                          onDelete: () {},
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return spaceY(extra: 5);
                      },
                    )
                  : Container(),
              spaceY(extra: 15),
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
          padding: Platform.isIOS
              ? const EdgeInsets.only(bottom: 30)
              : const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/png/pin.png",
                height: 25,
              ),
              spaceX(),
              Text(
                  "Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}",
                  style: TextStyle(
                      fontSize: 14,
                      color: context.theme.onPrimary,
                      fontWeight: FontWeight.w500))
            ],
          )),
    );
  }
}
