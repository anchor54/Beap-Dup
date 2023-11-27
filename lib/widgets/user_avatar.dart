import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

class UserAvatar extends StatelessWidget {
  final String? profileImg;
  final String userName;
  final double? fontSize;

  const UserAvatar(
      {super.key, this.profileImg, required this.userName, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: profileImg ?? "",
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 60,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => CircleAvatar(
        maxRadius: 60,
        backgroundColor: MyColor.blue,
        child: userName.length > 0
            ? Text(
                userName.substring(0, 1).toUpperCase(),
                style: TextStyle(
                    color: context.theme.primary, fontSize: fontSize ?? 32),
              )
            : null,
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        maxRadius: 60,
        backgroundColor: MyColor.blue,
        child: userName.length > 0
            ? Text(
                userName.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: context.theme.primary,
                  fontSize: fontSize ?? 32,
                ),
              )
            : null,
      ),
    );
  }
}
