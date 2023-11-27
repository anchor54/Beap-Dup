import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/view_model/create_or_edit_goal_vm.dart';
import 'package:jpshua/widgets/visibility_option.dart';

class PostVisibilityBottomSheet extends StatefulWidget {
  final PostVisibility? visibility;
  final Function(PostVisibility) onVisibilitySelected;

  const PostVisibilityBottomSheet(
      {super.key, this.visibility, required this.onVisibilitySelected});

  @override
  PostVisibilityBottomSheetState createState() =>
      PostVisibilityBottomSheetState(
          visibility: visibility ?? PostVisibility.PUBLIC);
}

class PostVisibilityBottomSheetState extends State<PostVisibilityBottomSheet> {
  PostVisibility visibility;
  PostVisibilityBottomSheetState({required this.visibility});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.spaceX(),
                    Text(
                      'View',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: MyColor.grey),
                        child: SvgPicture.asset("assets/svg/ic_round-add.svg"),
                      ),
                    )
                  ],
                ),
                widget.spaceY(extra: 14.0),
                Text(
                  'Who can view your goals',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                widget.spaceY(extra: 30.0),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return VisibilityOption(
                        visibility: PostVisibility.values[index],
                        isSelected: visibility == PostVisibility.values[index],
                        onSelected: (value) {
                          setState(() {
                            visibility = value;
                          });
                          widget.onVisibilitySelected(value);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return widget.spaceY(extra: 10.0);
                    },
                    itemCount: PostVisibility.values.length),
                widget.spaceY(extra: 35.0),
              ],
            ))
      ],
    );
  }
}
