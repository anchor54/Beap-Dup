import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

class IconTitleSubtitle extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final double? seperation;
  final TextStyle? titleFontStyle;
  final TextStyle? subtitleFontStyle;

  const IconTitleSubtitle(
      {super.key, this.title, this.subtitle, this.titleFontStyle, this.subtitleFontStyle, this.icon, this.seperation});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon ?? Container(),
        spaceX(extra: seperation ?? 0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: titleFontStyle ?? TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Visibility(
              child: Text(
                subtitle ?? '',
                style: subtitleFontStyle ?? TextStyle(
                  color: Color(0xFF0C82EE),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              visible: subtitle != null,
            )
          ],
        ),
      ],
    );
  }
}
