import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jpshua/model/goal_model.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/extensions/space.dart';
import '../constants/my_theme.dart';

class GoalItem extends StatelessWidget {
  final void Function() onTap;

  final String goalTitle;

  final String frequency;

  final String? skinGame;

  final void Function() onDelete;

  final bool slidable;

  final GoalVisibility? visibility;

  const GoalItem(
      {super.key,
      required this.goalTitle,
      required this.frequency,
      required this.skinGame,
      required this.onTap,
      required this.onDelete,
      required this.slidable,
      this.visibility = null});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      endActionPane: slidable
          ? ActionPane(
              motion: ScrollMotion(),
              children: [
                Container(
                  height: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                      child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Past',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
                ),
                Container(
                  height: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: ShapeDecoration(
                      color: Color(0x99FF0000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)))),
                  child: Center(
                      child: InkWell(
                    onTap: onDelete,
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
                ),
              ],
            )
          : null,

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: InkWell(
        onTap: onTap,
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: MyColor.greyBack,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(goalTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: context.theme.onPrimary,
                                fontWeight: FontWeight.w400)),
                        Text(
                          visibility?.title ?? '',
                          style: TextStyle(
                            color: Color(0xFF9A9A9A),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    spaceY(extra: 4),
                    Text(frequency,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w400)),
                    spaceY(),
                    Visibility(
                      visible: skinGame != null,
                      child: Text(skinGame!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF9A9A9A),
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ))),
      ),
    );
  }
}
