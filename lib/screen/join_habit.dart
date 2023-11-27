import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/home_vm.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';
import '../view_model/join_habit_vm.dart';
import '../widgets/base_widget.dart';
import 'base_home.dart';

class JoinHabit extends BaseWidget<JoinHabitVM>{
  const JoinHabit({super.key});

  @override
  Widget buildUI(BuildContext context, JoinHabitVM viewModel) {
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
          backgroundColor: context.theme.primary,
          elevation: 0,
        title: Text(strTitle,
            style: TextStyle(
                fontSize:28,
                color:context.theme.onPrimary,
                fontWeight: FontWeight.w700)),
          leading:InkWell(
              onTap:(){
                context.pop();
              },
              child: Icon(Icons.arrow_back,color:context.theme.onPrimary,)),
          actions: [
            InkWell(
              onTap:(){
                context.read<HomeVM>().setPage(0);
                context.pushAndRemoveUntil(const BaseHome());
              },
              child: Row(
                children: [
                  Text("Skip",
                      style: TextStyle(
                        fontSize: 14,
                        color:context.theme.onSecondary,
                      )),
                  Icon(Icons.arrow_forward_ios_rounded,color:context.theme.onSecondary,size:15,),
                ],
              ),
            ),
            spaceX(extra:5),
        ],
      ),
      extendBody: true,
      backgroundColor: context.theme.primary,
      body: SafeArea(
          child:SingleChildScrollView(
            child:Padding(
                padding:const EdgeInsets.only(top:10,left:15,right:15,bottom:15),
                child:Align(
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
                        padding: const EdgeInsets.only(right: 5),
                        child: TextFormField(
                          style:TextStyle(fontSize:12,color:context.theme.onPrimary),
                          cursorColor:context.theme.onPrimary,
                          textAlign:TextAlign.center,
                          controller:viewModel.searchController,
                          onTap: () {
                          },
                          onChanged: (value) {
                            if(value.isNotEmpty) {
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabled: true,
                            contentPadding:const EdgeInsets.only(left:15,top:15),
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
                      spaceY(extra:10),
                      InkWell(
                        onTap:(){
                          Share.share('check out my website https://example.com');
                        },
                        child: Padding(
                        padding: const EdgeInsets.only(top:8,bottom:8,left:5,right: 5),
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
                                      radius:25,
                                      backgroundColor:MyColor.blue,
                                      child:Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:12),),
                                    ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                      radius:25,
                                      backgroundColor:MyColor.blue,
                                      child:Text(HiveUtils.getSession<String>(SessionKey.name, defaultValue: "").substring(0,1).toUpperCase(),style:TextStyle(color:context.theme.primary,fontSize:12),),
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
                      spaceY(extra:10),
                    HiveUtils.getSession<String>(SessionKey.habitName,defaultValue:"")!="null"?
                    Text("Join ${HiveUtils.getSession<String>(SessionKey.habitName,defaultValue: "")}",
                          style: TextStyle(
                              fontSize: 14,
                              color:context.theme.onSecondary,
                              fontWeight: FontWeight.w500)):Text("Join ",
                        style: TextStyle(
                            fontSize: 14,
                            color:context.theme.onSecondary,
                            fontWeight: FontWeight.w500)),
                      spaceY(extra:5),
                      !viewModel.isNoData?ListView.builder(
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
                                    viewModel.status=index;
                                    HiveUtils.addSession(SessionKey.invitedId, viewModel.friendList[index].sId.toString());
                                    viewModel.friendList[index].isInvitedInGoal==false? viewModel.sendInivition(index,viewModel.status):print("");
                                  },
                                  child: Container(
                                      width:60,
                                      height:30,
                                      decoration:BoxDecoration(
                                          color:MyColor.lightGrey,
                                          borderRadius:BorderRadius.circular(15)
                                      ),
                                      child:Center(
                                        child:Text(viewModel.friendList[index].isInvitedInGoal==true?"Invited":"Invite",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:viewModel.friendList[index].isInvitedInGoal==true?MyColor.blue:context.theme.onPrimary,
                                                fontWeight: FontWeight.w500)),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          );

                        },
                      ):Padding(
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


                    ],),
                )
            ),
          )
      ),
    );
  }


}