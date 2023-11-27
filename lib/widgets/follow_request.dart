import 'package:flutter/material.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/widgets/user_avatar.dart';

class FollowRequests extends StatelessWidget {
  final List<UserFollowModel> requested;
  final Function()? goTo;

  const FollowRequests({super.key, required this.requested, this.goTo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStackedUserImg(),
            spaceX(extra: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Follow requests',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                spaceY(extra: 8),
                Text(
                  '${requested.first.userName} ${requested.length > 1 ? "+ ${requested.length} others" : ""}',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0.08,
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: const Color(0xFF0099F8),
                borderRadius: BorderRadius.all(Radius.elliptical(200, 300)),
              ),
            ),
            spaceX(extra: 12),
            InkWell(
                onTap: goTo,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.theme.onPrimary,
                  size: 16,
                ))
          ],
        )
      ],
    );
  }

  Widget _buildStackedUserImg() {
    return Stack(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(40)),
          child: UserAvatar(
            userName: requested.first.name ?? '',
            profileImg: requested.first.image,
            fontSize: 20,
          ),
        ),
        if (requested.length > 1)
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: UserAvatar(
              userName: requested[1].name ?? '',
              profileImg: requested[1].image,
              fontSize: 20,
            ),
          )
      ],
    );
  }
}
