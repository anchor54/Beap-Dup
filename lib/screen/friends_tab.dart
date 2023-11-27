import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/appStrings.dart';
import '../view_model/friends_tab_vm.dart';
import '../widgets/base_widget.dart';

class FriendsTab extends BaseWidget<FriendTabVM>{
  const FriendsTab({super.key});

  @override
  Widget buildUI(BuildContext context, FriendTabVM viewModel) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor: context.theme.primary,
          elevation: 0,
          centerTitle:true,
          title: Text(strTitle,
              style: TextStyle(
                  fontSize:28,
                  color:context.theme.onPrimary,
                  fontWeight: FontWeight.w700)),
          leading:InkWell(
              onTap:(){
                context.pop();
              },
              child: Icon(Icons.arrow_back,color:context.theme.onPrimary,))
      ),
      extendBody: true,
      backgroundColor: context.theme.primary,
      body: SafeArea(
        child:Padding(
          padding:const EdgeInsets.all(12),
          child:Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Container(
                height: 45.0,
                decoration: BoxDecoration(
                  color:MyColor.greyBack,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(10.0)),
                ),
                // padding: const EdgeInsets.only(right: 5),
                child: TextFormField(
                  textAlign:TextAlign.center,
                  controller:viewModel.searchController,
                  style:TextStyle(fontSize:12,color:context.theme.onPrimary),
                  cursorColor:context.theme.onPrimary,
                  onFieldSubmitted: (value){
                    if(value.isEmpty){
                      viewModel.clearSearch();
                    }else{
                      viewModel.getFriendSugesstion();
                    }
                  },
                  // onChanged: (value){
                  //   if(value.isEmpty) {
                  //     viewModel.clearSearch();
                  //   }else if(value.length >= 3){
                  //     viewModel.getFriendSugesstion();
                  //   }
                  // },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabled: true,
                    contentPadding:const EdgeInsets.only(left:15,top:15,right:15),
                    hintText: "Add or search friends",
                    prefixIcon: IconButton(
                      icon: SvgPicture.asset(
                        "assets/svg/search.svg",
                      ),
                      onPressed: () {},
                    ),
                    hintStyle: TextStyle(color:context.theme.onSecondary,
                        fontSize: 13.0),
                  ),
                ),
              ),
              spaceY(extra:5),
              viewModel.searchController.text.isEmpty?
              Expanded(child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageView(
                  physics:const NeverScrollableScrollPhysics(),
                  controller: viewModel.pageController,
                  onPageChanged: (page){
                    viewModel.tabPage = page;
                  },
                  children: [
                    // SingleChildScrollView(
                    //   child:Column(
                    //     mainAxisAlignment:MainAxisAlignment.start,
                    //     crossAxisAlignment:CrossAxisAlignment.start,
                    //     children:  [
                    //       InkWell(
                    //         onTap:(){
                    //         Share.share("Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}",);
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(top:8,bottom:8,),
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           height: 50,width:50,
                    //           margin: const EdgeInsets.only(
                    //               bottom: 5),
                    //           decoration: const BoxDecoration(
                    //             shape: BoxShape.circle,
                    //           ),
                    //           child: CachedNetworkImage(
                    //             imageUrl:viewModel.profileImg,
                    //             imageBuilder: (context,
                    //                 imageProvider) =>
                    //                 CircleAvatar(
                    //                   radius:50,
                    //                   backgroundImage: imageProvider,
                    //                 ),
                    //             placeholder: (context, url) =>
                    //             CircleAvatar(
                    //               radius:50,
                    //               backgroundColor:MyColor.blue,
                    //               child: Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),),
                    //             ),
                    //             errorWidget: (context, url, error) =>
                    //             CircleAvatar(
                    //               radius:50,
                    //               backgroundColor:MyColor.blue,
                    //               child: Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         spaceX(extra:10),
                    //         Expanded(
                    //           flex:1,
                    //           child: Column(
                    //             mainAxisAlignment:MainAxisAlignment.start,
                    //             crossAxisAlignment:CrossAxisAlignment.start,
                    //             mainAxisSize:MainAxisSize.max,
                    //             children: [
                    //               Text("Invite friends on Beap",
                    //                   style: TextStyle(
                    //                       fontSize: 14,
                    //                       color:context.theme.onPrimary,
                    //                       fontWeight: FontWeight.w500)),
                    //               spaceY(),
                    //               Text("Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}",
                    //                   style: TextStyle(
                    //                     fontSize: 14,
                    //                     color:context.theme.onSecondary,
                    //                   )),
                    //
                    //             ],
                    //           ),
                    //         ),
                    //         spaceX(),
                    //         SvgPicture.asset("assets/svg/download.svg")
                    //
                    //       ],
                    //     ),
                    //   ),
                    //       ),
                    //      //  spaceY(extra:5),
                    //      //  Text("Add your contacts",
                    //      //      style: TextStyle(
                    //      //          fontSize: 16,
                    //      //          color:context.theme.onSecondary,
                    //      //          fontWeight: FontWeight.w500)),
                    //      //  spaceY(extra:10),
                    //      // !viewModel.isNoData ?ListView.builder(
                    //      //    shrinkWrap: true,
                    //      //    itemCount:viewModel.onAddScreen.length,
                    //      //    primary:true,
                    //      //    physics: const ScrollPhysics(),
                    //      //    scrollDirection: Axis.vertical,
                    //      //    itemBuilder:(context, index){
                    //      //      return Padding(
                    //      //        padding: const EdgeInsets.only(top:8,bottom:8),
                    //      //        child: Row(
                    //      //          children: [
                    //      //            Container(
                    //      //              height: 50,width:50,
                    //      //              margin: const EdgeInsets.only(
                    //      //                  bottom: 5),
                    //      //              decoration: const BoxDecoration(
                    //      //                shape: BoxShape.circle,
                    //      //              ),
                    //      //              child: CachedNetworkImage(
                    //      //                imageUrl:viewModel.onAddScreen[index].image!="null"?"$baseUrl${viewModel.onAddScreen[index].image}":"",
                    //      //                imageBuilder: (context,
                    //      //                    imageProvider) =>
                    //      //                    CircleAvatar(
                    //      //                      radius:50,
                    //      //                      backgroundImage: imageProvider,
                    //      //                    ),
                    //      //                placeholder: (context, url) =>
                    //      //                     CircleAvatar(
                    //      //                      radius:50,
                    //      //                      backgroundColor:MyColor.blue,
                    //      //                      child: Text(viewModel.onAddScreen[index].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                    //      //                      ),
                    //      //                    ),
                    //      //                errorWidget: (context, url, error) =>
                    //      //                    CircleAvatar(
                    //      //                      radius:50,
                    //      //                      backgroundColor:MyColor.blue,
                    //      //                      child: Text(viewModel.onAddScreen[index].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                    //      //                      ),
                    //      //                    ),
                    //      //              ),
                    //      //            ),
                    //      //            spaceX(extra:10),
                    //      //            Expanded(
                    //      //              flex:1,
                    //      //              child: Column(
                    //      //                mainAxisAlignment:MainAxisAlignment.start,
                    //      //                crossAxisAlignment:CrossAxisAlignment.start,
                    //      //                mainAxisSize:MainAxisSize.max,
                    //      //                children: [
                    //      //                  Text(viewModel.onAddScreen[index].name.toString(),
                    //      //                      style: TextStyle(
                    //      //                          fontSize: 14,
                    //      //                          color:context.theme.onPrimary,
                    //      //                          fontWeight: FontWeight.w500)),
                    //      //                  spaceY(),
                    //      //                  viewModel.onAddScreen[index].userName.toString()!="null"? Text(viewModel.onAddScreen[index].userName.toString(),
                    //      //                      style: TextStyle(
                    //      //                        fontSize: 14,
                    //      //                        color:context.theme.onSecondary,
                    //      //                      )):Container()
                    //      //
                    //      //                ],
                    //      //              ),
                    //      //            ),
                    //      //            spaceX(),
                    //      //            InkWell(
                    //      //              onTap:(){
                    //      //                HiveUtils.addSession(SessionKey.recipientId,viewModel.onAddScreen[index].sId.toString());
                    //      //                viewModel.sendFriendRequest(index);
                    //      //              },
                    //      //              child: Container(
                    //      //                  width:60,
                    //      //                  height:30,
                    //      //                  decoration:BoxDecoration(
                    //      //                      color:MyColor.lightGrey,
                    //      //                      borderRadius:BorderRadius.circular(15)
                    //      //                  ),
                    //      //                  child:Center(
                    //      //                    child:Text("Add",
                    //      //                        style: TextStyle(
                    //      //                            fontSize: 14,
                    //      //                            color:context.theme.onPrimary,
                    //      //                            fontWeight: FontWeight.w500)),
                    //      //                  )
                    //      //              ),
                    //      //            ),
                    //      //            spaceX(),
                    //      //            InkWell(
                    //      //              onTap:(){
                    //      //                viewModel.deleteFriendRequest(index,viewModel.onAddScreen[index].mobile.toString());
                    //      //
                    //      //              },
                    //      //                child: Icon(Icons.close,color:context.theme.onPrimary,size:20,)),
                    //      //
                    //      //
                    //      //          ],
                    //      //        ),
                    //      //      );
                    //      //
                    //      //    },
                    //      //  ):Center(
                    //      //   child:Text("No Contact yet",textAlign:TextAlign.center,
                    //      //       style: TextStyle(
                    //      //           fontSize:14,
                    //      //           color:context.theme.onPrimary,
                    //      //           fontWeight: FontWeight.w500)),
                    //      // ),
                    //      //  spaceY(extra:10),
                    //      //  Visibility(
                    //      //    visible:viewModel.onInvite.isNotEmpty?true:false,
                    //      //    child: Text("Invite your contacts to Beap",
                    //      //        style: TextStyle(
                    //      //            fontSize: 16,
                    //      //            color:context.theme.onSecondary,
                    //      //            fontWeight: FontWeight.w500)),
                    //      //  ),
                    //      //  Visibility(
                    //      //      visible:viewModel.onInvite.isNotEmpty?true:false,
                    //      //      child: spaceY(extra:5)),
                    //      //  !viewModel.isNoContact?ListView.builder(
                    //      //    shrinkWrap: true,
                    //      //    itemCount:viewModel.onInvite.length + 1,
                    //      //    primary:true,
                    //      //    physics: const ScrollPhysics(),
                    //      //    scrollDirection: Axis.vertical,
                    //      //    itemBuilder:(context, index){
                    //      //      return  index == viewModel.onInvite.length?Visibility(
                    //      //          visible: viewModel.isCallNoData,
                    //      //          child: Center(
                    //      //              child: Padding(
                    //      //                padding: const EdgeInsets.symmetric(vertical: 10),
                    //      //                child: Wrap(
                    //      //                  crossAxisAlignment: WrapCrossAlignment.center,
                    //      //                  children:  [
                    //      //                    CircularProgressIndicator(color:context.theme.onPrimary,),
                    //      //                    Padding(
                    //      //                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    //      //                      child: Text("Syncing",style:TextStyle(color:context.theme.onPrimary),),
                    //      //                    )
                    //      //                  ],
                    //      //                ),
                    //      //              ))):
                    //      //        Visibility(
                    //      //          visible:viewModel.onInvite[index].contactname.toString().isNotEmpty?true:false,
                    //      //          child: Padding(
                    //      //          padding: const EdgeInsets.only(top:8,bottom:8),
                    //      //          child: Row(
                    //      //            children: [
                    //      //              Container(
                    //      //                height: 50,width:50,
                    //      //                margin: const EdgeInsets.only(
                    //      //                    bottom: 5),
                    //      //                decoration: const BoxDecoration(
                    //      //                  shape: BoxShape.circle,
                    //      //                ),
                    //      //                child: CachedNetworkImage(
                    //      //                  imageUrl:"",
                    //      //                  imageBuilder: (context,
                    //      //                      imageProvider) =>
                    //      //                      CircleAvatar(
                    //      //                        radius:50,
                    //      //                        backgroundImage: imageProvider,
                    //      //                      ),
                    //      //                  placeholder: (context, url) =>
                    //      //                       CircleAvatar(
                    //      //                        radius:50,
                    //      //                        backgroundColor:MyColor.blue,
                    //      //                        child: Text(viewModel.onInvite[index].contactname.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                    //      //                        ),
                    //      //                      ),
                    //      //                  errorWidget: (context, url, error) =>
                    //      //                      CircleAvatar(
                    //      //                        radius:50,
                    //      //                        backgroundColor:MyColor.blue,
                    //      //                        child: Text(viewModel.onInvite[index].contactname.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                    //      //                        ),
                    //      //                      ),
                    //      //                ),
                    //      //              ),
                    //      //              spaceX(extra:10),
                    //      //              Expanded(
                    //      //                flex:1,
                    //      //                child: Column(
                    //      //                  mainAxisAlignment:MainAxisAlignment.start,
                    //      //                  crossAxisAlignment:CrossAxisAlignment.start,
                    //      //                  mainAxisSize:MainAxisSize.max,
                    //      //                  children: [
                    //      //                    Text(viewModel.onInvite[index].contactname.toString(),
                    //      //                        style: TextStyle(
                    //      //                            fontSize: 14,
                    //      //                            color:context.theme.onPrimary,
                    //      //                            fontWeight: FontWeight.w500)),
                    //      //                    spaceY(),
                    //      //                    // Text("via SMS ${viewModel.onInvite[index].mobileNo.toString()}",
                    //      //                    //     style: TextStyle(
                    //      //                    //       fontSize: 14,
                    //      //                    //       color:context.theme.onSecondary,
                    //      //                    //     )),
                    //      //
                    //      //                  ],
                    //      //                ),
                    //      //              ),
                    //      //              spaceX(),
                    //      //              viewModel.onInvite[index].invited==false?
                    //      //              InkWell(
                    //      //                onTap:(){
                    //      //                  viewModel.sendInivition(viewModel.onInvite[index].mobileNo.toString(),index);
                    //      //
                    //      //                },
                    //      //                child: Container(
                    //      //                    width:60,
                    //      //                    height:30,
                    //      //                    decoration:BoxDecoration(
                    //      //                        color:MyColor.lightGrey,
                    //      //                        borderRadius:BorderRadius.circular(15)
                    //      //                    ),
                    //      //                    child:Center(
                    //      //                      child:Text("Invite",
                    //      //                          style: TextStyle(
                    //      //                              fontSize: 14,
                    //      //                              color:context.theme.onPrimary,
                    //      //                              fontWeight: FontWeight.w500)),
                    //      //                    )
                    //      //                ),
                    //      //              ): Container(
                    //      //                  width:60,
                    //      //                  height:30,
                    //      //                  decoration:BoxDecoration(
                    //      //                      color:MyColor.lightGrey,
                    //      //                      borderRadius:BorderRadius.circular(15)
                    //      //                  ),
                    //      //                  child:Center(
                    //      //                    child:Text("Invited",
                    //      //                        style: TextStyle(
                    //      //                            fontSize: 14,
                    //      //                            color:MyColor.blue,
                    //      //                            fontWeight: FontWeight.w500)),
                    //      //                  )
                    //      //              ),
                    //      //
                    //      //
                    //      //            ],
                    //      //          ),
                    //      //      ),
                    //      //        );
                    //      //
                    //      //    },
                    //      //  ):Center(child:Text("No Contact Found",style:TextStyle(fontSize:16,color:context.theme.onPrimary),),)
                    //
                    //
                    //     ],
                    //   ),
                    // ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children:  [
                          InkWell(
                            onTap:(){
                              Share.share("Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top:8,bottom:8,),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,width:50,
                                    margin: const EdgeInsets.only(
                                        bottom: 5),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:viewModel.profileImg,
                                      imageBuilder: (context,
                                          imageProvider) =>
                                          CircleAvatar(
                                            radius:50,
                                            backgroundImage: imageProvider,
                                          ),
                                      placeholder: (context, url) =>
                                          CircleAvatar(
                                            radius:50,
                                            backgroundColor:MyColor.blue,
                                            child: Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                            radius:50,
                                            backgroundColor:MyColor.blue,
                                            child: Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                            ),
                                          ),
                                    ),
                                  ),
                                  spaceX(extra:10),
                                  Expanded(
                                    flex:1,
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      mainAxisSize:MainAxisSize.max,
                                      children: [
                                        Text("Invite friends on Beap",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:context.theme.onPrimary,
                                                fontWeight: FontWeight.w500)),
                                        spaceY(),
                                        Text("Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:context.theme.onSecondary,
                                            )),

                                      ],
                                    ),
                                  ),
                                  spaceX(),
                                  SvgPicture.asset("assets/svg/download.svg")

                                ],
                              ),
                            ),
                          ),
                          spaceY(extra:5),
                          Text("My friends (${viewModel.friendList.length})",
                              style: TextStyle(
                                  fontSize: 16,
                                  color:context.theme.onSecondary,
                                  fontWeight: FontWeight.w500)),
                          spaceY(extra:5),
                          !viewModel.isNoFriend?ListView.builder(
                            shrinkWrap: true,
                            itemCount:viewModel.friendList.length,
                            primary:true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder:(context, index){
                              return Padding(
                                padding: const EdgeInsets.only(top:8,bottom:8),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,width:50,
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:viewModel.friendList[index].image!="null"?"$baseUrl${viewModel.friendList[index].image}":"",
                                        imageBuilder: (context,
                                            imageProvider) =>
                                            CircleAvatar(
                                              radius:50,
                                              backgroundImage: imageProvider,
                                            ),
                                        placeholder: (context, url) =>
                                            CircleAvatar(
                                              radius:50,
                                              backgroundColor:MyColor.blue,
                                              child: Text(viewModel.friendList[index].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            CircleAvatar(
                                              radius:50,
                                              backgroundColor:MyColor.blue,
                                              child: Text(viewModel.friendList[index].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                              ),
                                            ),
                                      ),
                                    ),
                                    spaceX(extra:10),
                                    Expanded(
                                      flex:1,
                                      child: Column(
                                        mainAxisAlignment:MainAxisAlignment.start,
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisSize:MainAxisSize.max,
                                        children: [
                                          Text(viewModel.friendList[index].name.toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:context.theme.onPrimary,
                                                  fontWeight: FontWeight.w500)),
                                          spaceY(),
                                          Text(viewModel.friendList[index].userName.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:context.theme.onSecondary,
                                              )),

                                        ],
                                      ),
                                    ),
                                    spaceX(),
                                    InkWell(
                                      onTap:(){
                                        HiveUtils.addSession(SessionKey.recipientId,viewModel.friendList[index].sId.toString());
                                        viewModel.unFriendRequest(index);
                                      },
                                        child: Icon(Icons.close,color:context.theme.onPrimary,size:20,)),


                                  ],
                                ),
                              );

                            },
                          ):  Padding(
                            padding: const EdgeInsets.only(top:15),
                            child: Column(
                              children: [
                                Center(
                                  child: Text("No Friends yet",textAlign:TextAlign.center,
                                      style: TextStyle(
                                          fontSize:14,
                                          color:context.theme.onPrimary,
                                          fontWeight: FontWeight.w500)),
                                ),
                                spaceY(extra:2),
                                Center(
                                  child: Text("you do not have any friends on Beap.",textAlign:TextAlign.center,
                                      style: TextStyle(
                                          fontSize:14,
                                          color:context.theme.onSecondary,
                                          fontWeight: FontWeight.w400)),
                                ),


                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child:Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children:  [
                          InkWell(
                            onTap:(){
                              Share.share("Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top:8,bottom:8,),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,width:50,
                                    margin: const EdgeInsets.only(
                                        bottom: 5),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:viewModel.profileImg,
                                      imageBuilder: (context,
                                          imageProvider) =>
                                          CircleAvatar(
                                            radius:50,
                                            backgroundImage: imageProvider,
                                          ),
                                      placeholder: (context, url) =>
                                          CircleAvatar(
                                            radius:50,
                                            backgroundColor:MyColor.blue,
                                            child: Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                            radius:50,
                                            backgroundColor:MyColor.blue,
                                            child: Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                            ),
                                          ),
                                    ),
                                  ),
                                  spaceX(extra:10),
                                  Expanded(
                                    flex:1,
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      mainAxisSize:MainAxisSize.max,
                                      children: [
                                        Text("Invite friends on Beap",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:context.theme.onPrimary,
                                                fontWeight: FontWeight.w500)),
                                        spaceY(),
                                        Text("Beap.io/${HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "")}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:context.theme.onSecondary,
                                            )),

                                      ],
                                    ),
                                  ),
                                  spaceX(),
                                  SvgPicture.asset("assets/svg/download.svg")

                                ],
                              ),
                            ),
                          ),
                          spaceY(extra:5),
                          if (viewModel.status==0) Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisSize:MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Friend requests (${viewModel.getFriendRequest.length})",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:context.theme.onSecondary,
                                          fontWeight: FontWeight.w500)),
                                  InkWell(
                                    onTap:(){
                                      viewModel.status=1;
                                      viewModel.getSendFriendsRequest();
                                    },
                                    child:  Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Text("Sent",
                                            style: TextStyle(
                                                fontSize:14,
                                                color:context.theme.onSecondary,
                                                fontWeight: FontWeight.w500)),
                                        spaceX(),
                                        Icon(Icons.arrow_forward_ios_rounded,color:context.theme.onSecondary,size:15,)

                                      ],
                                    ),),

                                ],),
                              spaceY(extra:5),
                              !viewModel.isNoFriendData?ListView.builder(
                                shrinkWrap: true,
                                itemCount:viewModel.getFriendRequest.length,
                                primary:true,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder:(context, index){
                                  return Padding(
                                    padding: const EdgeInsets.only(top:8,bottom:8),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,width:50,
                                          margin: const EdgeInsets.only(
                                              bottom: 5),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:viewModel.getFriendRequest[index].user![0].image!="null"?"$baseUrl${viewModel.getFriendRequest[index].user![0].image}":"",
                                            imageBuilder: (context,
                                                imageProvider) =>
                                                CircleAvatar(
                                                  radius:50,
                                                  backgroundImage: imageProvider,
                                                ),
                                            placeholder: (context, url) =>
                                                CircleAvatar(
                                                  radius:50,
                                                  backgroundColor:MyColor.blue,
                                                  child: Text(viewModel.getFriendRequest[index].user![0].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                                  ),
                                                ),
                                            errorWidget: (context, url, error) =>
                                                CircleAvatar(
                                                  radius:50,
                                                  backgroundColor:MyColor.blue,
                                                  child: Text(viewModel.getFriendRequest[index].user![0].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                                  ),
                                                ),
                                          ),
                                        ),
                                        spaceX(extra:10),
                                        Expanded(
                                          flex:1,
                                          child: Column(
                                            mainAxisAlignment:MainAxisAlignment.start,
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            mainAxisSize:MainAxisSize.max,
                                            children: [
                                              Text(viewModel.getFriendRequest[index].user![0].name.toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:context.theme.onPrimary,
                                                      fontWeight: FontWeight.w500)),
                                              spaceY(),
                                              Text(viewModel.getFriendRequest[index].user![0].userName.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:context.theme.onSecondary,
                                                  )),

                                            ],
                                          ),
                                        ),
                                        spaceX(),
                                        InkWell(
                                          onTap:(){
                                            HiveUtils.addSession(SessionKey.recipientId,viewModel.getFriendRequest[index].sId.toString());
                                            viewModel.acceptRequest(index,"Accept",viewModel.getFriendRequest);
                                          },
                                          child: Container(
                                              width:60,
                                              height:30,
                                              decoration:BoxDecoration(
                                                  color:MyColor.lightGrey,
                                                  borderRadius:BorderRadius.circular(15)
                                              ),
                                              child:Center(
                                                child:Text("Add",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:context.theme.onPrimary,
                                                        fontWeight: FontWeight.w500)),
                                              )
                                          ),
                                        ),
                                        spaceX(),
                                        InkWell(
                                          onTap:(){
                                            HiveUtils.addSession(SessionKey.recipientId,viewModel.getFriendRequest[index].sId.toString());
                                            viewModel.acceptRequest(index,"Reject",viewModel.getFriendRequest);
                                          },
                                            child: Icon(Icons.close,color:context.theme.onPrimary,size:20,)),


                                      ],
                                    ),
                                  );

                                },
                              ):
                              Padding(
                                padding: const EdgeInsets.only(top:15),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text("No pending requests",textAlign:TextAlign.center,
                                          style: TextStyle(
                                              fontSize:14,
                                              color:context.theme.onPrimary,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    spaceY(extra:2),
                                    Center(
                                      child: Text("you don’t have any pending requests",textAlign:TextAlign.center,
                                          style: TextStyle(
                                              fontSize:14,
                                              color:context.theme.onSecondary,
                                              fontWeight: FontWeight.w400)),
                                    ),


                                  ],
                                ),
                              ),

                            ],
                          ) else Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisSize:MainAxisSize.max,
                            children: [
                              Text("Sent requests (${viewModel.sendRequest.length})",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:context.theme.onSecondary,
                                      fontWeight: FontWeight.w500)),
                              spaceY(extra:5),
                              !viewModel.isNoSendData?ListView.builder(
                                shrinkWrap: true,
                                itemCount:viewModel.sendRequest.length,
                                primary:true,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder:(context, index){
                                  return Padding(
                                    padding: const EdgeInsets.only(top:8,bottom:8),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,width:50,
                                          margin: const EdgeInsets.only(
                                              bottom: 5),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:viewModel.sendRequest[index].user![0].image!="null"?"$baseUrl${viewModel.sendRequest[index].user![0].image}":"",
                                            imageBuilder: (context,
                                                imageProvider) =>
                                                CircleAvatar(
                                                  radius:50,
                                                  backgroundImage: imageProvider,
                                                ),
                                            placeholder: (context, url) =>
                                                CircleAvatar(
                                                  radius:50,
                                                  backgroundColor:MyColor.blue,
                                                  child: Text(viewModel.sendRequest[index].user![0].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                                  ),
                                                ),
                                            errorWidget: (context, url, error) =>
                                                CircleAvatar(
                                                  radius:50,
                                                  backgroundColor:MyColor.blue,
                                                  child: Text(viewModel.sendRequest[index].user![0].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                                  ),
                                                ),
                                          ),
                                        ),
                                        spaceX(extra:10),
                                        Expanded(
                                          flex:1,
                                          child: Column(
                                            mainAxisAlignment:MainAxisAlignment.start,
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            mainAxisSize:MainAxisSize.max,
                                            children: [
                                              Text(viewModel.sendRequest[index].user![0].name.toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:context.theme.onPrimary,
                                                      fontWeight: FontWeight.w500)),
                                              spaceY(),
                                              Text(viewModel.sendRequest[index].user![0].userName.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:context.theme.onSecondary,
                                                  )),

                                            ],
                                          ),
                                        ),
                                        spaceX(),
                                        InkWell(
                                          onTap:(){
                                            HiveUtils.addSession(SessionKey.recipientId,viewModel.sendRequest[index].sId.toString());
                                            viewModel.acceptRequest(index,"Reject",viewModel.sendRequest);
                                          },
                                            child: Icon(Icons.close,color:context.theme.onPrimary,size:20,)),


                                      ],
                                    ),
                                  );

                                },
                              ):
                              Padding(
                                padding: const EdgeInsets.only(top:15),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text("No pending requests",textAlign:TextAlign.center,
                                          style: TextStyle(
                                              fontSize:14,
                                              color:context.theme.onPrimary,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    spaceY(extra:2),
                                    Center(
                                      child: Text("you don’t have any pending requests",textAlign:TextAlign.center,
                                          style: TextStyle(
                                              fontSize:14,
                                              color:context.theme.onSecondary,
                                              fontWeight: FontWeight.w400)),
                                    ),


                                  ],
                                ),
                              ),

                            ],
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              )):Expanded(child:!viewModel.isNoSearchData ?
              SingleChildScrollView(
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:  [
                       spaceY(extra:5),
                      Text("More Results",
                          style: TextStyle(
                              fontSize: 16,
                              color:context.theme.onSecondary,
                              fontWeight: FontWeight.w500)),
                       spaceY(extra:10),
                      ListView.builder(
                         shrinkWrap: true,
                         itemCount:viewModel.searchList.length,
                         primary:true,
                         physics: const ScrollPhysics(),
                         scrollDirection: Axis.vertical,
                         itemBuilder:(context, index){
                           return Padding(
                             padding: const EdgeInsets.only(top:8,bottom:8),
                             child: Row(
                               children: [
                                 Container(
                                   height: 50,width:50,
                                   margin: const EdgeInsets.only(
                                       bottom: 5),
                                   decoration: const BoxDecoration(
                                     shape: BoxShape.circle,
                                   ),
                                   child: CachedNetworkImage(
                                     imageUrl:viewModel.searchList[index].image!="null"?"$baseUrl${viewModel.searchList[index].image}":"",
                                     imageBuilder: (context,
                                         imageProvider) =>
                                         CircleAvatar(
                                           radius:50,
                                           backgroundImage: imageProvider,
                                         ),
                                     placeholder: (context, url) =>
                                          CircleAvatar(
                                           radius:50,
                                           backgroundColor:MyColor.blue,
                                           child: Text(viewModel.searchList[index].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                           ),
                                         ),
                                     errorWidget: (context, url, error) =>
                                         CircleAvatar(
                                           radius:50,
                                           backgroundColor:MyColor.blue,
                                           child: Text(viewModel.searchList[index].name.toString().substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:16,),
                                           ),
                                         ),
                                   ),
                                 ),
                                 spaceX(extra:10),
                                 Expanded(
                                   flex:1,
                                   child: Column(
                                     mainAxisAlignment:MainAxisAlignment.start,
                                     crossAxisAlignment:CrossAxisAlignment.start,
                                     mainAxisSize:MainAxisSize.max,
                                     children: [
                                       Text(viewModel.searchList[index].name.toString(),
                                           style: TextStyle(
                                               fontSize: 14,
                                               color:context.theme.onPrimary,
                                               fontWeight: FontWeight.w500)),
                                       spaceY(),
                                       viewModel.searchList[index].userName.toString()!="null"? Text(viewModel.searchList[index].userName.toString(),
                                           style: TextStyle(
                                             fontSize: 14,
                                             color:context.theme.onSecondary,
                                           )):Container()

                                     ],
                                   ),
                                 ),
                                 spaceX(),
                                 viewModel.searchList[index].friend!=null&&viewModel.searchList[index].friend!.status=="pending"?
                                 InkWell(
                                   onTap:(){
                                     // HiveUtils.addSession(SessionKey.recipientId,viewModel.searchList[index].sId.toString());
                                     // viewModel.sendFriendRequest(index);
                                   },
                                   child: Container(
                                       width:85,
                                       height:30,
                                       decoration:BoxDecoration(
                                           color:MyColor.lightGrey,
                                           borderRadius:BorderRadius.circular(15)
                                       ),
                                       child:Center(
                                         child:Text("Requested",
                                             style: TextStyle(
                                                 fontSize: 14,
                                                 color:context.theme.onPrimary,
                                                 fontWeight: FontWeight.w500)),
                                       )
                                   ),
                                 ):viewModel.searchList[index].friend!=null&&viewModel.searchList[index].friend!.status=="accepted"?
                                 InkWell(
                                   onTap:(){
                                     // HiveUtils.addSession(SessionKey.recipientId,viewModel.searchList[index].sId.toString());
                                     // viewModel.acceptRequest(index,"Reject",viewModel.searchList);
                                     // viewModel.sendFriendRequest(index);
                                   },
                                   child: Container(
                                       width:60,
                                       height:30,
                                       decoration:BoxDecoration(
                                           color:MyColor.lightGrey,
                                           borderRadius:BorderRadius.circular(15)
                                       ),
                                       child:Center(
                                         child:Text("Added",
                                             style: TextStyle(
                                                 fontSize: 14,
                                                 color:context.theme.onPrimary,
                                                 fontWeight: FontWeight.w500)),
                                       )
                                   ),
                                 ):InkWell(
                                   onTap:(){
                                     HiveUtils.addSession(SessionKey.recipientId,viewModel.searchList[index].sId.toString());
                                     viewModel.sendFriendRequest(index);
                                   },
                                   child: Container(
                                       width:60,
                                       height:30,
                                       decoration:BoxDecoration(
                                           color:MyColor.lightGrey,
                                           borderRadius:BorderRadius.circular(15)
                                       ),
                                       child:Center(
                                         child:Text("Add",
                                             style: TextStyle(
                                                 fontSize: 14,
                                                 color:context.theme.onPrimary,
                                                 fontWeight: FontWeight.w500)),
                                       )
                                   ),
                                 ),
                                 spaceX(),
                                 // InkWell(
                                 //   onTap:(){
                                 //     // viewModel.deleteFriendRequest(index,viewModel.searchList[index].mobile.toString());
                                 //
                                 //   },
                                 //     child: Icon(Icons.close,color:context.theme.onPrimary,size:20,)),


                               ],
                             ),
                           );

                         },
                       )
                    ],
                  ),
                ),
              ): Align(
                alignment:Alignment.center,
                child:Text("No user Found",textAlign:TextAlign.center,
                    style: TextStyle(
                        fontSize:14,
                        color:context.theme.onPrimary,
                        fontWeight: FontWeight.w500)),
              ),
              )


            ],
          ),
        )

      ),
      bottomNavigationBar: Padding(
        padding:Platform.isIOS?const EdgeInsets.only(bottom:20):const EdgeInsets.only(bottom:10),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            // TextButton(onPressed:(){
            //   viewModel.tabPage = 0;
            //   viewModel.pageController.jumpToPage(0);
            //   viewModel.status=0;
            //
            // }, child:Text("Contacts",
            //     style: TextStyle(
            //         fontSize: 16,
            //         color:viewModel.tabPage == 0 ? context.theme.onPrimary: context.theme.onSecondary,
            //         fontWeight: FontWeight.w700)),
            // ),
            TextButton(onPressed:(){
              viewModel.tabPage = 0;
              viewModel.pageController.jumpToPage(0);
              viewModel.friendsList();
              viewModel.status=0;
            }, child:Text("Friends",
                style: TextStyle(
                    fontSize: 16,
                    color:viewModel.tabPage == 0 ? context.theme.onPrimary: context.theme.onSecondary,
                    fontWeight: FontWeight.w700)),),
            TextButton(onPressed:(){
              viewModel.tabPage = 1;
              viewModel.pageController.jumpToPage(1);
              viewModel.friendsRequest();
              viewModel.status=0;
            }, child:Text("Requests",
                style: TextStyle(
                    fontSize: 16,
                    color:viewModel.tabPage == 1 ? context.theme.onPrimary: context.theme.onSecondary,
                    fontWeight: FontWeight.w700)),),
          ],
        ),
      )
    );
  }
}