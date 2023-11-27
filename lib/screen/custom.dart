import 'package:flutter/material.dart';
import 'package:jpshua/constants/Toasty.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/custom_vm.dart';
import 'package:jpshua/view_model/repeat_vm.dart';
import 'package:jpshua/widgets/base_widget.dart';

import '../constants/my_theme.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class Custom extends BaseWidget<CustomVM> {
  const Custom({super.key});

  @override
  Widget buildUI(BuildContext context, CustomVM viewModel) {
    return Scaffold(
      // backgroundColor: context.theme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: context.theme.primary,
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              context.pop();
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
                                  "Repeat",
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
                            "Custom",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: context.theme.onPrimary),
                          ),
                        )
                      ],
                    ),
                    spaceY(extra: 20),
                    Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12, bottom: 12, left: 8, right: 8),
                          child: InkWell(
                            onTap: () {
                              viewModel.isFrequencyTime = true;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Frequency",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: context.theme.onPrimary,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Text(
                                  viewModel.frequency,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: viewModel.isFrequencyTime == true
                                          ? MyColor.themeBlue
                                          : context.theme.onSecondary),
                                ),
                              ],
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 1,
                    ),
                    Visibility(
                      visible: viewModel.isFrequencyTime == true ? true : false,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColor.greyBack,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewModel.frequent.length,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    viewModel.indexFreqValue = index;
                                    viewModel.frequency =
                                        viewModel.frequent[index].toString();
                                    HiveUtils.addSession(SessionKey.every, "1");
                                    HiveUtils.addSession(
                                        SessionKey.everyfre,
                                        viewModel.frequency == "Daily"
                                            ? "Day"
                                            : viewModel.frequency == "Weekly"
                                                ? "week"
                                                : viewModel.frequency ==
                                                        "Monthly"
                                                    ? "month"
                                                    : "");
                                    print(
                                        "------frequency--${viewModel.frequency}");
                                    viewModel.every =
                                        "${HiveUtils.getSession<String>(SessionKey.every, defaultValue: "").isNotEmpty ? HiveUtils.getSession<String>(SessionKey.every) : "1"}${" "}${viewModel.frequency == "Daily" ? "Day" : viewModel.frequency == "Weekly" ? "week" : viewModel.frequency == "Monthly" ? "month" : ""}";
                                    viewModel.occur =
                                        "${HiveUtils.getSession<String>(SessionKey.every, defaultValue: "").isNotEmpty ? HiveUtils.getSession<String>(SessionKey.every) : "1"}${" "}${viewModel.frequency == "Daily" ? "day" : viewModel.frequency == "Weekly" ? "week" : viewModel.frequency == "Monthly" ? "month" : ""}";
                                    viewModel.occur =
                                        "${HiveUtils.getSession<String>(SessionKey.every, defaultValue: "").isNotEmpty ? HiveUtils.getSession<String>(SessionKey.every) : "1"}${" "}${viewModel.frequency == "Daily" ? "day" : viewModel.frequency == "Weekly" ? "week" : viewModel.frequency == "Monthly" ? "month" : ""}";
                                    viewModel.tempOccur =
                                        "${HiveUtils.getSession<String>(SessionKey.every, defaultValue: "").isNotEmpty ? HiveUtils.getSession<String>(SessionKey.every) : "1"}${" "}${viewModel.frequency == "Daily" ? "day" : viewModel.frequency == "Weekly" ? "week" : viewModel.frequency == "Monthly" ? "month" : ""}";
                                    viewModel.selectedWeek.clear();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              viewModel.indexFreqValue == index
                                                  ? MyColor.greyCircle
                                                  : MyColor.greyBack,
                                          borderRadius:
                                              viewModel.indexFreqValue == index
                                                  ? BorderRadius.circular(20)
                                                  : BorderRadius.circular(0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            viewModel.frequent[index]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: viewModel
                                                            .indexFreqValue ==
                                                        index
                                                    ? context.theme.onPrimary
                                                    : context
                                                        .theme.onSecondary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12, bottom: 12, left: 8, right: 8),
                          child: InkWell(
                            onTap: () {
                              viewModel.isEveryTime = true;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Every",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: context.theme.onPrimary,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Text(
                                  viewModel.every,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: viewModel.isEveryTime == true
                                          ? MyColor.themeBlue
                                          : context.theme.onSecondary),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Visibility(
                      visible: viewModel.isEveryTime == true ? true : false,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2, top: 2),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: MyColor.greyBack,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: viewModel.daily.length,
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          viewModel.indexEveryValue = index;
                                          HiveUtils.addSession(SessionKey.every,
                                              "${viewModel.daily[index]}");
                                          HiveUtils.addSession(
                                              SessionKey.everyfre,
                                              viewModel.frequency == "Daily"
                                                  ? "Day"
                                                  : viewModel.frequency ==
                                                          "Weekly"
                                                      ? "week"
                                                      : viewModel.frequency ==
                                                              "Monthly"
                                                          ? "month"
                                                          : "");
                                          viewModel.every =
                                              "${viewModel.daily[index]}${" "}${viewModel.frequency == "Daily" ? "Day" : viewModel.frequency == "Weekly" ? "week" : viewModel.frequency == "Monthly" ? "month" : ""}";
                                          viewModel.occur =
                                              "${viewModel.daily[index]}${" "}${viewModel.frequency == "Daily" ? "day" : viewModel.frequency == "Weekly" ? "week" : viewModel.frequency == "Monthly" ? "month" : ""}";
                                          viewModel.tempOccur =
                                              "${viewModel.daily[index]}${" "}${viewModel.frequency == "Daily" ? "day" : viewModel.frequency == "Weekly" ? "week" : viewModel.frequency == "Monthly" ? "month" : ""}";
                                          print(
                                              "------every--${viewModel.every}");
                                          viewModel.frequency == "Daily"
                                              ? print("j")
                                              : viewModel.onweakChange(
                                                  viewModel.frequency);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    viewModel.indexEveryValue ==
                                                            index
                                                        ? MyColor.greyCircle
                                                        : MyColor.greyBack,
                                                borderRadius: viewModel
                                                            .indexEveryValue ==
                                                        index
                                                    ? BorderRadius.circular(20)
                                                    : BorderRadius.circular(0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      viewModel.daily[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: viewModel
                                                                      .indexEveryValue ==
                                                                  index
                                                              ? context.theme
                                                                  .onPrimary
                                                              : context.theme
                                                                  .onSecondary),
                                                    ),
                                                    // Visibility(
                                                    //   visible: viewModel.indexEveryValue==index?true:false,
                                                    //   child: Text(viewModel.frequency=="Daily"?"Day":viewModel.frequency=="Weekly"?"Week":viewModel.frequency=="Monthly"?"Month":"",style: TextStyle(fontSize: 16,
                                                    //       fontWeight: FontWeight.normal,
                                                    //       color:viewModel.indexEveryValue==index?context.theme.onPrimary:context.theme.onSecondary),),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  viewModel.frequency == "Daily"
                                      ? "Day"
                                      : viewModel.frequency == "Weekly"
                                          ? "Week"
                                          : viewModel.frequency == "Monthly"
                                              ? "Month"
                                              : "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: context.theme.onPrimary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 14),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Event will occur every ${viewModel.occur}.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: context.theme.onPrimary),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: viewModel.frequency == "Weekly" ? true : false,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: viewModel.Weeks.length,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  viewModel.toggleDaySelection(index);
                                },
                                child: SizedBox(
                                  height: 45,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          viewModel.Weeks[index].name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: context.theme.onPrimary),
                                        ),
                                        Visibility(
                                            visible:
                                                viewModel.Weeks[index].status,
                                            child: Icon(
                                              Icons.check,
                                              color: MyColor.themeBlue,
                                            ))
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              color: context.theme.primary,
                              height: 2,
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: viewModel.frequency == "Monthly" ? true : false,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColor.greyBack,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 12, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Each",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: context.theme.onPrimary),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: MyColor.themeBlue,
                                  )
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding:const EdgeInsets.only(left:12,top:10,),
                            //   child: Container(color:context.theme.onPrimary.withOpacity(0.2),height:1,),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, left: 2, right: 2),
                              child: SizedBox(
                                height: 280,
                                child: GridView.count(
                                    // mainAxisSpacing: 2.0,
                                    // crossAxisSpacing: 2.0,
                                    childAspectRatio: 1.15,
                                    physics: const ScrollPhysics(),
                                    crossAxisCount: 7,
                                    children: List.generate(
                                        viewModel.months.length, (index) {
                                      return InkWell(
                                        onTap: () {
                                          viewModel.toggleMonthSelection(index);
                                        },
                                        child: Container(
                                          // height:50,width:50,
                                          decoration: BoxDecoration(
                                              color:
                                                  viewModel.months[index].status
                                                      ? MyColor.themeBlue
                                                      : MyColor.greyBack,
                                              border: Border.all(
                                                  color: context.theme.onPrimary
                                                      .withOpacity(0.2))),

                                          child: Center(
                                            child: Text(
                                              viewModel.months[index].id
                                                  .toString(),
                                              style: TextStyle(
                                                  color: viewModel
                                                          .months[index].status
                                                      ? context.theme.primary
                                                      : context.theme.onPrimary,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
