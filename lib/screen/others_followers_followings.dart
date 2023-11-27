import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/components/followers_followings/searchable_other_user_list.dart';
import 'package:jpshua/components/followers_followings/tab_title.dart';
import 'package:jpshua/components/followers_followings/searchable_user_list.dart';
import 'package:jpshua/components/followers_followings/user_follower_item.dart';
import 'package:jpshua/components/followers_followings/user_following_item.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/followers_followings_vm.dart';
import 'package:jpshua/view_model/others_followers_followings_vm.dart';
import 'package:jpshua/widgets/base_widget.dart';

import '../view_model/base_vm.dart';

class _OthersFollowersFollowingsState
    extends BaseWidgetState<OthersFollowersFollowingsVM> {
  @override
  void initState() {
    super.initState();
    v.tabPage = (widget as OthersFollowersFollowings).tabIndex ?? 0;
  }
}

class OthersFollowersFollowings
    extends BaseWidget<OthersFollowersFollowingsVM> {
  final int? tabIndex;

  OthersFollowersFollowings({this.tabIndex = 0, super.key});

  @override
  State<BaseWidget<BaseViewModel>> createState() =>
      _OthersFollowersFollowingsState();

  @override
  Widget buildUI(BuildContext context, OthersFollowersFollowingsVM viewModel) {
    viewModel.pageController = PageController(initialPage: viewModel.tabPage);
    int followerCount = viewModel.followersCount;
    int followingCount = viewModel.followingsCount;
    print("Followings $followingCount");
    return Scaffold(
      extendBody: true,
      backgroundColor: context.theme.primary,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, viewModel.name),
            TabTitle(
                titles: [
                  "$followerCount Followers",
                  "$followingCount Followings"
                ],
                selectedIdx: viewModel.tabPage,
                onTap: (idx) {
                  viewModel.tabPage = idx;
                  viewModel.pageController.animateToPage(idx,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                }),
            Expanded(
                child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: viewModel.pageController,
                    onPageChanged: (idx) {
                      viewModel.tabPage = idx;
                    },
                    children: [
                  SearchableOtherUserList(
                      title: "Followers",
                      userList: viewModel.followers,
                      userItem: (user) => UserFollowingItem(
                          user: user,
                          isFollowing: viewModel.myFollowings
                              .where((following) => following.uId == user.uId)
                              .isNotEmpty,
                          onFollow: (userId, callback) {
                            viewModel.follow(userId, callback: callback);
                          },
                          onUnFollow: (userId, callback) {
                            viewModel.unfollow(userId, callback: callback);
                          }),
                      onSearch: (search) {
                        viewModel.searchFollowers(search: search);
                      }),
                  SearchableOtherUserList(
                      title: "Followings",
                      userList: viewModel.followings,
                      userItem: (user) => UserFollowingItem(
                          user: user,
                          isFollowing: viewModel.myFollowings
                              .where((following) => following.uId == user.uId)
                              .isNotEmpty,
                          onUnFollow: (userId, callback) {
                            viewModel.unfollow(userId, callback: callback);
                          },
                          onFollow: (userId, callback) {
                            viewModel.follow(userId, callback: callback);
                          }),
                      onSearch: (search) {
                        viewModel.searchFollowings(search: search);
                      }),
                ]))
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String? name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                context.pop();
              },
              child: SvgPicture.asset('assets/svg/back_icon.svg')),
          // centerTitle: true,
          Text(name ?? '',
              style: TextStyle(
                  fontSize: 18,
                  color: context.theme.onPrimary,
                  fontWeight: FontWeight.w700)),
          Container()
        ],
      ),
    );
  }
}
