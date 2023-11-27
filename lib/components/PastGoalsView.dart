import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

import '../constants/my_theme.dart';
import '../model/goal_model.dart';

class PastGoalsView extends StatelessWidget {
  final List<GoalModel> pastGoalsList;
  final void Function(String) onGoalTapped;
  final void Function() onViewAllGoalsTapped;

  const PastGoalsView(
    {super.key,
    required this.pastGoalsList,
    required this.onGoalTapped,
    required this.onViewAllGoalsTapped}
  );

  /**
   * onGoalTapped: () {
      HiveUtils.addSession(SessionKey.activityId,
      pastGoalsList[index].sId.toString());
      context.push(GoalSummary(title: "Summary"));
    },
    onViewAllGoalsTapped: () {
      context.push(const AllPastGoals());
    },
   */

  @override
  Widget build(BuildContext context) {
    return pastGoalsList.isNotEmpty
        ? SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: pastGoalsList.length,
                    primary: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onGoalTapped(pastGoalsList[index].sId.toString());
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: MyColor.greyBack,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        pastGoalsList[index].habitTitle
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: context.theme.onPrimary,
                                            fontWeight: FontWeight.w500)),
                                    spaceY(),
                                    Text(
                                        "${pastGoalsList[index].completionPercentage.toString()} ${""}% Successful",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: context.theme.onSecondary,
                                            fontWeight: FontWeight.w500)),
                                    spaceY(),
                                    Text(
                                        "${DateFormat.MMMd().format(DateFormat("yyyy-MM-dd").parse(pastGoalsList[index].startDate.toString()))}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: context.theme.onSecondary,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ))),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return spaceY(extra: 5);
                    },
                  ),
                  spaceY(extra: 15),
                  InkWell(
                      onTap: onViewAllGoalsTapped,
                      child: SizedBox(
                        width: 150,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("View All Past Goals",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context.theme.onSecondary,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: context.theme.onSecondary,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
        )
        : Center(
            child: Text("You don’t have any past goals yet.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: context.theme.onPrimary,
                    fontWeight: FontWeight.w500)));
  }
}
