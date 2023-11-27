import 'package:flutter/material.dart';
import 'package:jpshua/model/goal_model.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import '../utils/extensions/space.dart';
import 'GoalItem.dart';

class ActiveGoalsView extends StatelessWidget {
  final List<GoalModel> goalsList;
  final void Function(String) onGoalTapped;
  final void Function() onViewAllGoalsTapped;
  final void Function()? onAddToPastGoals;
  final void Function(String?)? onDelete;

  const ActiveGoalsView(
      {super.key,
      required this.goalsList,
      required this.onGoalTapped,
      required this.onViewAllGoalsTapped,
      this.onAddToPastGoals,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return goalsList.isNotEmpty ? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: goalsList.length,
              primary: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GoalItem(
                    key: new Key(goalsList[index].sId ?? ""),
                    slidable: onAddToPastGoals != null && onDelete != null,
                    goalTitle: goalsList[index].habitTitle.toString(),
                    visibility: goalsList[index].visibility,
                    frequency: goalsList[index].repeat!.type.toString() ==
                            "Custom Repeat"
                        ? "${"Every"}${" "}${goalsList[index].repeat!.every!.type.toString()}${" "}${goalsList[index].repeat!.every!.frequency.toString()}"
                        : goalsList[index].repeat!.type.toString(),
                    skinGame: goalsList[index].skinGame,
                    onTap: () {
                      onGoalTapped(goalsList[index].sId.toString());
                    },
                    onDelete: () {
                      onDelete?.call(goalsList[index].sId);
                    });
              },
              separatorBuilder: (BuildContext context, int index) {
                return spaceY(extra: 5);
              },
            ),
            spaceY(extra: 15),
            goalsList.isNotEmpty
                ? InkWell(
                    onTap: onViewAllGoalsTapped,
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("View All Goals",
                              textAlign: TextAlign.center,
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
                    ))
                : Container()
          ],
        ),
      ),
    ) : Center(
            child: Text("You don’t have any past goals yet.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: context.theme.onPrimary,
                    fontWeight: FontWeight.w500)));
  }
}
