import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/screen/others_profile_screen.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/widgets/user_avatar.dart';

import '../../constants/my_theme.dart';
import '../../utils/appStrings.dart';

class UserFollowingItem extends StatefulWidget {
  final UserFollowModel user;
  final Function(String, VoidCallback?) onFollow;
  final Function(String, VoidCallback?) onUnFollow;
  final bool? isFollowing;

  UserFollowingItem(
      {super.key,
      this.isFollowing = true,
      required this.user,
      required this.onFollow,
      required this.onUnFollow});

  @override
  State<StatefulWidget> createState() => UserFollowingItemState();
}

class UserFollowingItemState extends State<UserFollowingItem> {
  bool _isFollowing = true;
  @override
  void initState() {
    _isFollowing = widget.isFollowing ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HiveUtils.addSession(SessionKey.selectedUserId, widget.user.uId);
        context.push(OthersProfileScreen());
      },
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: UserAvatar(
              profileImg: widget.user.image,
              userName: widget.user.name ?? '',
              fontSize: 24,
            ),
          ),
          widget.spaceX(extra: 24),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(widget.user.name ?? '',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.theme.onPrimary,
                        fontWeight: FontWeight.w500)),
                widget.spaceY(),
                Text(
                    (widget.user.userName != null &&
                            widget.user.userName!.isNotEmpty)
                        ? '@${widget.user.userName}'
                        : '',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.theme.onSecondary,
                    )),
              ],
            ),
          ),
          widget.spaceX(),
          if (widget.user.uId != null &&
              widget.user.uId != HiveUtils.getSession(SessionKey.userId))
            InkWell(
              onTap: () {
                if (!_isFollowing) {
                  widget.onFollow(widget.user.uId!, () {
                    setState(() {
                      _isFollowing = true;
                    });
                  });
                } else {
                  widget.onUnFollow(widget.user.uId!, () {
                    setState(() {
                      _isFollowing = false;
                    });
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                decoration: ShapeDecoration(
                  color: Color(0xFFEFEFEF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(
                  _isFollowing ? 'Following' : 'Follow',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
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
