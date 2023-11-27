import 'package:flutter/material.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import '../constants/my_theme.dart';

class RectangleThemeButton extends StatelessWidget {
  const RectangleThemeButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final Function()? onTap;
  final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 17,
        right:17,
        bottom: 10,
      ),
      height:40,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(
                MyColor.themeBlue),
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                 RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft:
                      Radius.circular(20),
                      bottomRight:
                      Radius.circular(20),
                    ),
                    side: BorderSide(
                        color: MyColor.themeBlue)))),
        onPressed:onTap,
        child: Center(
          child: Text(text,
              style: TextStyle(
                  fontSize:
                  16,
                  color: context.theme.primary,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}