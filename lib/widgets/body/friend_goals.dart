import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/model/friend_model.dart';
import 'package:jpshua/utils/appStrings.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

class FriendGoals extends StatelessWidget {
  final List<FriendModel> friendList;
  final String message;
  final Function() onAddFriendsTapped;

  const FriendGoals({super.key, required this.message, required this.friendList, required this.onAddFriendsTapped});

  @override
  Widget build(BuildContext context) {
    return
        //   mainAxisSize:MainAxisSize.max,
        //   mainAxisAlignment:((goalCount)!="0")?MainAxisAlignment.center:MainAxisAlignment.center,
        //   children: [
        //     Visibility(
        //       visible:((goalCount)=="0")?true:false,
        //       child: Column(
        //         mainAxisAlignment:MainAxisAlignment.center,
        //         children: [
        //           Text("You don’t have any active goals yet.",textAlign:TextAlign.center,
        //               style: TextStyle(
        //                   fontSize:16,
        //                   color:context.theme.onPrimary,
        //                   fontWeight: FontWeight.w500)),
        //           spaceY(extra:10),
        //           InkWell(
        //               onTap:()  {
        //                 context.push(const NewGoal());
        //                 // context.push(const TitleScreen());
        //               },
        //               child:SizedBox(
        //                 width:120,
        //                 child:Row(
        //                   mainAxisAlignment:MainAxisAlignment.center,
        //
        //                   children: [
        //                     Text("Let’s begin",
        //                         style: TextStyle(
        //                             fontSize:16,
        //                             color:context.theme.onPrimary,
        //                             fontWeight: FontWeight.w500)),
        //                     spaceX(),
        //                     Icon(Icons.arrow_forward,color:context.theme.onPrimary,size:20,)
        //
        //                   ],
        //                 ),
        //               )
        //           ),
        //
        //
        //         ],
        //       ),
        //     ),
        //     Visibility(
        //       visible:((goalCount)!="0")?true:false,
        //       child: Column(
        //         mainAxisAlignment:MainAxisAlignment.center,
        //         crossAxisAlignment:CrossAxisAlignment.center,
        //         children: [
        //           Text("You don’t have any active goals yet.",textAlign:TextAlign.center,
        //               style: TextStyle(
        //                   fontSize:16,
        //                   color:context.theme.onPrimary,
        //                   fontWeight: FontWeight.w500)),
        //           // spaceY(extra:10),
        //           // InkWell(
        //           //     onTap:()  {
        //           //       context.push(const NewGoal());
        //           //       // context.push(const TitleScreen());
        //           //     },
        //           //     child:SizedBox(
        //           //       width:120,
        //           //       child:Row(
        //           //         mainAxisAlignment:MainAxisAlignment.center,
        //           //
        //           //         children: [
        //           //           Text("Let’s begin",
        //           //               style: TextStyle(
        //           //                   fontSize:16,
        //           //                   color:context.theme.onPrimary,
        //           //                   fontWeight: FontWeight.w500)),
        //           //           spaceX(),
        //           //           Icon(Icons.arrow_forward,color:context.theme.onPrimary,size:20,)
        //           //
        //           //         ],
        //           //       ),
        //           //     )
        //           // ),
        //           Align(
        //               alignment:Alignment.bottomCenter,
        //               child: GestureDetector(
        //                 onTap: ()
        //                 async {
        //                   await availableCameras().then((value) => Navigator.push(context,
        //                       MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
        //                 },
        //                 child: Image.asset("assets/png/camera.png",color:context.theme.onPrimary,height:80,),
        //               )),
        //         ],
        //       ),
        //     ),
        //
        //   ],
        // ),
        friendList.length > 0
            ? SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: friendList.length,
                    primary: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: friendList[index]
                                                  .createdBy!
                                                  .image !=
                                              "null"
                                          ? "$baseUrl${friendList[index].createdBy!.image}"
                                          : "",
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        radius: 50,
                                        backgroundImage: imageProvider,
                                      ),
                                      placeholder: (context, url) =>
                                          CircleAvatar(
                                        radius: 50,
                                        backgroundColor: MyColor.blue,
                                        child: Text(
                                          friendList[index]
                                              .createdBy!
                                              .name
                                              .toString()
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: context.theme.primary,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                        radius: 50,
                                        backgroundColor: MyColor.blue,
                                        child: Text(
                                          friendList[index]
                                              .createdBy!
                                              .name
                                              .toString()
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: context.theme.primary,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  spaceX(extra: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                            friendList[index]
                                                .createdBy!
                                                .name
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: context.theme.onPrimary,
                                                fontWeight: FontWeight.w500)),
                                        spaceY(),
                                        Text(
                                            friendList[index]
                                                .activity!
                                                .habitTitle
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: context.theme.onSecondary,
                                            )),
                                      ],
                                    ),
                                  ),
                                  spaceX(),
                                  SvgPicture.asset("assets/svg/clone.svg"),
                                ],
                              ),
                              spaceY(extra: 5),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10)),
                                child: CachedNetworkImage(
                                  height: 250,
                                  width: double.infinity,
                                  imageUrl: friendList[index].image != "null"
                                      ? "$baseUrl${friendList[index].image}"
                                      : "",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    height: 250,
                                    width: double.infinity,
                                    decoration:
                                        BoxDecoration(color: MyColor.primary),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: 250,
                                    width: double.infinity,
                                    decoration:
                                        BoxDecoration(color: MyColor.primary),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                  )
                  // spaceY(extra:15),
                  // Text("Overdue Goals",
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         color:context.theme.onPrimary,
                  //         fontWeight: FontWeight.w500)),
                  // spaceY(extra:5),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount:2,
                  //   primary:true,
                  //   physics: const ScrollPhysics(),
                  //   scrollDirection: Axis.vertical,
                  //   itemBuilder:(context, index){
                  //     return Padding(
                  //       padding: const EdgeInsets.only(top:8,bottom:8),
                  //       child: Row(
                  //         children: [
                  //           Container(
                  //             height: 50,width:50,
                  //             margin: const EdgeInsets.only(
                  //                 bottom: 5),
                  //             decoration: const BoxDecoration(
                  //               shape: BoxShape.circle,
                  //             ),
                  //             child: CachedNetworkImage(
                  //               imageUrl:"",
                  //               imageBuilder: (context,
                  //                   imageProvider) =>
                  //                   CircleAvatar(
                  //                     radius:50,
                  //                     backgroundImage: imageProvider,
                  //                   ),
                  //               placeholder: (context, url) =>
                  //               const CircleAvatar(
                  //                 radius:50,
                  //                 backgroundImage:AssetImage(
                  //                     "assets/png/img.png"),
                  //               ),
                  //               errorWidget: (context, url, error) =>
                  //               const CircleAvatar(
                  //                 radius:50,
                  //                 backgroundImage:AssetImage(
                  //                     "assets/png/img.png"),
                  //               ),
                  //             ),
                  //           ),
                  //           spaceX(extra:10),
                  //           Expanded(
                  //             flex:1,
                  //             child: Column(
                  //               mainAxisAlignment:MainAxisAlignment.start,
                  //               crossAxisAlignment:CrossAxisAlignment.start,
                  //               mainAxisSize:MainAxisSize.max,
                  //               children: [
                  //                 Text("Steve Jobs",
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         color:context.theme.onPrimary,
                  //                         fontWeight: FontWeight.w500)),
                  //                 spaceY(),
                  //                 Text("Daily golf with friends ",
                  //                     style: TextStyle(
                  //                       fontSize: 14,
                  //                       color:context.theme.onSecondary,
                  //                     )),
                  //
                  //               ],
                  //             ),
                  //           ),
                  //           spaceX(),
                  //           Container(
                  //               width:80,
                  //               height:30,
                  //               decoration:BoxDecoration(
                  //                   color:MyColor.lightGrey,
                  //                   borderRadius:BorderRadius.circular(15)
                  //               ),
                  //               child:Center(
                  //                 child:Text("Remind",
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         color:context.theme.onPrimary,
                  //                         fontWeight: FontWeight.w500)),
                  //               )
                  //           ),
                  //
                  //
                  //         ],
                  //       ),
                  //     );
                  //
                  //   },
                  // ),
                ],
              ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(message,
                      // "You don’t have any friends on Beap.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: context.theme.onPrimary,
                          fontWeight: FontWeight.w500)),
                  spaceY(extra: 10),
                  Visibility(
                    visible: message == "Your friends have not posted today."
                        ? false
                        : true,
                    child: InkWell(
                      onTap: onAddFriendsTapped,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Add Friends",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: context.theme.onPrimary,
                                  fontWeight: FontWeight.w500)),
                          spaceX(),
                          Icon(
                            Icons.arrow_forward,
                            color: context.theme.onPrimary,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
  }
}
