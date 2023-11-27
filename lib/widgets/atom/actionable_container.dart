import 'package:flutter/material.dart';

import 'package:jpshua/constants/my_theme.dart';

class ActionableContainer extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final Function()? onTap;

  ActionableContainer(
      {super.key, required this.child, this.onTap, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          color: MyColor.greyBack,
          borderRadius: borderRadius ??
              const BorderRadius.all(
                Radius.circular(2),
              ),
        ),
        child: InkWell(onTap: onTap, child: child));
  }
}
