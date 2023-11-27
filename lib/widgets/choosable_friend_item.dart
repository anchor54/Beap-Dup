import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/widgets/user_avatar.dart';

class ChoosableFriendItem extends StatelessWidget {
  final String friendId;

  final String? imageUrl;

  final String? title;

  final String? subtitle;

  final bool isSelected;

  final Function()? onSelected;

  const ChoosableFriendItem({
    Key? key,
    required this.friendId,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Row(
          children: [
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: UserAvatar(
                profileImg: imageUrl,
                userName: title ?? '',
              ),
            ),
            spaceX(extra: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  spaceY(extra: 4),
                  Text(
                    subtitle ?? "",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              SvgPicture.asset(
                'assets/svg/checked.svg',
                width: 20,
                height: 20,
              )
            else
              SvgPicture.asset(
                'assets/svg/unselected-radio.svg',
                width: 20,
                height: 20,
              ),
          ],
        ),
      ),
    );
  }
}
