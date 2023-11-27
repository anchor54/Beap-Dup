import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/model/calendar_model.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/session_key.dart';

import '../screen/calendar_view.dart';
import '../utils/hive_utils.dart';
import 'base_vm.dart';

class CalendarScreenVm extends BaseViewModel{
  List<CalendarModel> calendar = [];
  @override
  initView() {
    getCalendarImage();

    return super.initView();
  }
  @override
  void dispose(){
    super.dispose();
  }
  void getCalendarImage(){
    calendar.clear();
    call(path: "Activity/monthlyTrack", onSuccess: (statusCode, data) {
      Map object = jsonDecode(data);
      if (object['result'] != null) {
        object['result'].forEach((v) {
          calendar.add(CalendarModel.fromJson(v));
        });
      }
      notifyListeners();

    },
      method: Method.get,isShowLoader:false, queryParameters: {
        "Activity_id":HiveUtils.getSession<String>(SessionKey.activityId,
            defaultValue: ""),
      },
    );

  }
  List<Meeting> getDataSource() {
    List<Meeting> meetings =[];
    if(calendar.isNotEmpty) {
      for(int i=0; i<calendar.length; i++) {
        meetings.add(
            Meeting(calendar[i].image.toString(),DateTime.parse(calendar[i].createdAt.toString()),DateTime.parse(calendar[i].createdAt.toString()),
                context.theme.onPrimary, false));
      }
    }

    return meetings;
  }

}