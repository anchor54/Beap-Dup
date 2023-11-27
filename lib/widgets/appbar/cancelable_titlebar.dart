import 'package:flutter/material.dart';


import 'package:jpshua/constants/my_theme.dart';


import 'package:jpshua/utils/extensions/theme_extension.dart';


class CancelableTitlebar extends StatelessWidget {

  final String? title;


  const CancelableTitlebar({super.key, this.title});


  @override

  Widget build(BuildContext context) {

    return Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Expanded(

          flex: 1,

          child: InkWell(

            onTap: () {

              Navigator.of(context).pop();

            },

            child: Row(

              children: [

                Icon(

                  Icons.arrow_back_ios,

                  color: MyColor.themeBlue,

                  size: 16,

                ),

                const SizedBox(

                  width: 1,

                ),

                Text(

                  "Cancel",

                  style: TextStyle(

                      fontSize: 16,

                      fontWeight: FontWeight.w500,

                      color: MyColor.themeBlue),

                ),

              ],

            ),

          ),

        ),

        Expanded(

          child: Text(

            title ?? "",

            style: TextStyle(

                fontSize: 16,

                fontWeight: FontWeight.w600,

                color: context.theme.onPrimary),

          ),

        )

      ],

    );

  }

}

