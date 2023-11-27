import 'package:flutter/material.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/screen/others_profile_screen.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/widgets/user_avatar.dart';

class UserFollowerItem extends StatelessWidget {
  final UserFollowModel user;
  final Function(String, VoidCallback?) onRemove;

  UserFollowerItem({super.key, required this.user, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HiveUtils.addSession(SessionKey.selectedUserId, user.uId);
        context.push(OthersProfileScreen());
      },
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: UserAvatar(
              profileImg: user.image,
              userName: user.name ?? '',
              fontSize: 24,
            ),
          ),
          spaceX(extra: 24),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(user.name ?? '',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.theme.onPrimary,
                        fontWeight: FontWeight.w500)),
                spaceY(),
                Text(
                    (user.userName != null && user.userName!.isNotEmpty)
                        ? '@${user.userName}'
                        : '',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.theme.onSecondary,
                    )),
              ],
            ),
          ),
          spaceX(extra: 10),
          InkWell(
            onTap: () {
              if (user.uId == null) return;
              onRemove(user.uId!, null);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration: ShapeDecoration(
                color: Color(0xFFEFEFEF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
              child: Text(
                'Remove',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
