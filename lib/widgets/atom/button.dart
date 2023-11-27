import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';

class Button extends StatelessWidget {
  final Function()? onClick;
  final String text;
  const Button({super.key, this.onClick, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
              color: MyColor.greyBack,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 8),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF616161),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ));
  }
}
