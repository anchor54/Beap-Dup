import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/appStrings.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileImageUrl;
  final Function()? onProfileTap;
  final Function()? onFriendsTap;

  const HomeAppBar(
      {Key? key,
      required this.profileImageUrl,
      required this.onFriendsTap,
      required this.onProfileTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.primary,
      elevation: 0,
      centerTitle: true,
      title: Text(strTitle,
          style: TextStyle(
              fontSize: 28,
              color: context.theme.onPrimary,
              fontWeight: FontWeight.w700)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
