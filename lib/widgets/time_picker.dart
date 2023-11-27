import 'package:flutter/cupertino.dart';


import 'package:jpshua/constants/my_theme.dart';


class TimePicker extends StatelessWidget {

  final DateTime? initialDateTime;


  final Function(DateTime) onDateTimeChanged;


  const TimePicker({

    super.key,

    this.initialDateTime,

    required this.onDateTimeChanged,

  });


  @override

  Widget build(BuildContext context) {

    return SizedBox(

      height: 170.0,

      child: CupertinoTheme(

          data: CupertinoThemeData(

            textTheme: CupertinoTextThemeData(

              dateTimePickerTextStyle: TextStyle(

                color: MyColor.onPrimary,

                fontSize: 20.0,

              ),

            ),

          ),

          child: CupertinoDatePicker(

            initialDateTime: this.initialDateTime,

            mode: CupertinoDatePickerMode.time,

            onDateTimeChanged: onDateTimeChanged,

          )),

    );

  }

}

