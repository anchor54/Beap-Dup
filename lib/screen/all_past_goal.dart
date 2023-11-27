// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:jpshua/constants/my_theme.dart';
// import 'package:jpshua/screen/add_active_goal/add_active_goal_title.dart';
// import 'package:jpshua/screen/add_past_goal/add_past_goal_title.dart';
// import 'package:jpshua/screen/otp.dart';
// import 'package:jpshua/screen/past_goal_summary.dart';
// import 'package:jpshua/screen/title.dart';
// import 'package:jpshua/utils/extensions/goto.dart';
// import 'package:jpshua/utils/extensions/space.dart';
// import 'package:jpshua/utils/extensions/theme_extension.dart';
// import 'package:jpshua/utils/hive_utils.dart';
// import 'package:jpshua/utils/session_key.dart';
// import 'package:jpshua/view_model/account_vm.dart';
// import 'package:jpshua/view_model/all_past_goal_vm.dart';
// import '../utils/appStrings.dart';
// import '../view_model/all_goal_vm.dart';
// import '../widgets/base_widget.dart';
//
// class AllPastGoals extends BaseWidget<PastGoalVM>{
//   const AllPastGoals({super.key});
//   @override
//   Widget buildUI(BuildContext context, PastGoalVM viewModel) {
//     return Scaffold(
//       appBar:AppBar(
//         backgroundColor: context.theme.primary,
//         centerTitle:true,
//         elevation: 0,
//         leading:InkWell(
//             onTap:(){
//               context.pop();
//             },
//             child: Icon(Icons.arrow_back,color:context.theme.onPrimary,)),
//         title: Text("All Past Goals",
//             style: TextStyle(
//                 fontSize:18,
//                 color:context.theme.onPrimary,
//                 fontWeight: FontWeight.w700)),
//         // actions: [
//         //   Padding(padding: const EdgeInsets.only(right:15),
//         //     child:PopupMenuButton(
//         //       color:MyColor.lightGrey,
//         //       shape:RoundedRectangleBorder(
//         //           borderRadius: BorderRadius.circular(10.0)
//         //       ),
//         //       icon: SvgPicture.asset("assets/svg/clone.svg"),
//         //       itemBuilder: (context) {
//         //         return [
//         //           PopupMenuItem(
//         //             value: 'Edit',
//         //             child: Text('Edit',textScaleFactor: 1,style:TextStyle(color:context.theme.onPrimary,fontSize:12),),
//         //           ),
//         //           PopupMenuItem(
//         //             value: 'Delete',
//         //             child: Text('Delete',textScaleFactor: 1,style:TextStyle(color:context.theme.onPrimary,fontSize:12),),
//         //           ),
//         //         ];
//         //       },
//         //       onSelected: (value){
//         //         String message;
//         //         if (value == 'Delete') {
//         //         }
//         //         else if(value == 'Edit'){
//         //
//         //         }
//         //         else {
//         //           message = 'Not implemented';
//         //         }
//         //       },
//         //     ),),
//         // ],
//       ),
//       extendBody: true,
//       backgroundColor: context.theme.primary,
//       body: SafeArea(
//           child:SingleChildScrollView(
//             child:Padding(
//               padding:const EdgeInsets.only(top:15,left:15,right:15,bottom:15),
//               child:Column(
//                 mainAxisAlignment:MainAxisAlignment.start,
//                 crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                       decoration:BoxDecoration(
//                           color:MyColor.lightGrey,
//                           borderRadius:BorderRadius.circular(10)
//                       ),
//                       child:Padding(
//                           padding:const EdgeInsets.all(13),
//                           child:InkWell(
//                             onTap:(){
//                               context.push(const PastTitleScreen());
//
//                             },
//                             child:Row(
//                               mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Add New Goal",textAlign:TextAlign.center,
//                                     style: TextStyle(
//                                         fontSize:14,
//                                         color:context.theme.onPrimary,
//                                         fontWeight: FontWeight.w500)),
//                                 Icon(Icons.arrow_forward_ios_rounded,color:context.theme.onPrimary),
//
//                               ],
//                             ),
//                           )
//                       )
//                   ),
//                   spaceY(),
//                   Padding(padding:const EdgeInsets.only(left:5),
//                     child: Text("Add more goals to your current list",textAlign:TextAlign.start,
//                         style: TextStyle(
//                             fontSize:12,
//                             color:context.theme.secondary,
//                             fontWeight: FontWeight.w400)),),
//                   spaceY(extra:15),
//                   !viewModel.isNoData? ListView.separated(
//                     shrinkWrap: true,
//                     itemCount:viewModel.activeGoal.length,
//                     primary:true,
//                     physics: const ScrollPhysics(),
//                     scrollDirection: Axis.vertical,
//                     itemBuilder:(context, index){
//                       return InkWell(
//                         onTap:(){
//                           HiveUtils.addSession(SessionKey.activityId,viewModel.activeGoal[index].sId.toString());
//                           context.push(GoalSummary(title:"Summary"));
//
//                         },
//                         child:Container(
//                             decoration:BoxDecoration(
//                                 color:MyColor.greyBack,
//                                 borderRadius:BorderRadius.circular(10)
//                             ),
//                             child:Padding(
//                                 padding:const EdgeInsets.all(13),
//                                 child:Column(
//                                   mainAxisAlignment:MainAxisAlignment.start,
//                                   crossAxisAlignment:CrossAxisAlignment.start,
//                                   children: [
//                                     Text(viewModel.activeGoal[index].habitTitle.toString(),textAlign:TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize:14,
//                                             color:context.theme.onPrimary,
//                                             fontWeight: FontWeight.w500)),
//                                     spaceY(),
//                                     Row(
//                                       mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("${viewModel.activeGoal[index].completionPercentage.toString()} ${""}% Successful",textAlign:TextAlign.center,
//                                             style: TextStyle(
//                                                 fontSize:12,
//                                                 color:context.theme.onSecondary,
//                                                 fontWeight: FontWeight.w500)),
//                                         InkWell(
//                                           onTap:(){
//                                             HiveUtils.addSession(SessionKey.activityId,viewModel.activeGoal[index].sId.toString());
//                                             viewModel.deleteGoal(index);
//
//                                           },
//                                             child: Icon(Icons.delete_forever,color:context.theme.onPrimary)),
//                                       ],
//                                     ),
//                                     spaceY(),
//                                     Text("${DateFormat.MMMd().format(DateFormat("MM-DD-yyy").parse(viewModel.activeGoal[index].startDate.toString()))} - ${DateFormat.MMMd().format(DateFormat("MM-DD-yyy").parse(viewModel.activeGoal[index].endDate.toString()))}",textAlign:TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize:12,
//                                             color:context.theme.onSecondary,
//                                             fontWeight: FontWeight.w500)),
//                                   ],
//                                 )
//                             )
//                         ),
//                       );
//
//                     }, separatorBuilder: (BuildContext context, int index) { return spaceY(extra:5); },
//                   ):Container(),
//                   spaceY(extra:15),
//
//
//
//                 ],
//               ),
//             ),
//           )
//       ),
//       bottomNavigationBar: Padding(
//           padding:Platform.isIOS?const EdgeInsets.only(bottom:30):const EdgeInsets.only(bottom:20),
//           child:Row(
//             mainAxisAlignment:MainAxisAlignment.center,
//             children: [
//               Image.asset("assets/png/pin.png",height:25,),
//               spaceX(),
//               Text("Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}",
//                   style: TextStyle(
//                       fontSize:14,
//                       color:context.theme.onPrimary,
//                       fontWeight: FontWeight.w500))
//             ],
//           )),
//     );
//   }
//
//
// }