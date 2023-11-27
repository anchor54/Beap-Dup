import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jpshua/screen/camera_page.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

class MyGoals extends StatelessWidget {
  final int goalCount;
  final int duePost;
  final Function() onAddNewGoalTapped;

  const MyGoals(
      {Key? key,
      required this.goalCount,
      required this.duePost,
      required this.onAddNewGoalTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (goalCount == 0)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You don’t have any active goals yet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: context.theme.onPrimary,
                      fontWeight: FontWeight.w500)),
              spaceY(extra: 10),
              InkWell(
                  onTap: onAddNewGoalTapped,
                  child: SizedBox(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Let’s begin",
                            style: TextStyle(
                                fontSize: 16,
                                color: context.theme.onPrimary,
                                fontWeight: FontWeight.w500)),
                        spaceX(),
                        Icon(
                          Icons.arrow_forward,
                          color: context.theme.onPrimary,
                          size: 20,
                        )
                      ],
                    ),
                  )),
            ],
          )
        : Align(
            alignment: Alignment.center,
            child: Text(
                "Your friends have not posted today.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.2,
                    height: 1.2,
                    color: context.theme.onPrimary,
                    fontWeight: FontWeight.w500)),
          );
  }
}
