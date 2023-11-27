import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/view_model/create_or_edit_goal_vm.dart';

class VisibilityOption extends StatelessWidget {
  final PostVisibility visibility;

  final bool isSelected;

  final Function(PostVisibility) onSelected;

  const VisibilityOption({
    Key? key,
    required this.visibility,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelected(visibility);
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visibility.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                spaceY(extra: 0.0),
                Text(
                  visibility.subtitle,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          (isSelected)
              ? SvgPicture.asset(
                  'assets/svg/selected-radio.svg',
                  width: 15,
                  height: 15,
                )
              : SvgPicture.asset(
                  'assets/svg/unselected-radio.svg',
                  width: 15,
                  height: 15,
                )
        ],
      ),
    );
  }
}
