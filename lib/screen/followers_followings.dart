import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jpshua/components/followers_followings/searchable_follower_list.dart';
import 'package:jpshua/components/followers_followings/tab_title.dart';
import 'package:jpshua/components/followers_followings/searchable_user_list.dart';
import 'package:jpshua/components/followers_followings/user_follower_item.dart';
import 'package:jpshua/components/followers_followings/user_following_item.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/followers_followings_vm.dart';
import 'package:jpshua/widgets/base_widget.dart';

import '../view_model/base_vm.dart';

class _FollowersFollowingsState extends BaseWidgetState<FollowersFollowingsVM> {
  @override
  void initState() {
    super.initState();
    v.tabPage = (widget as FollowersFollowings).tabIndex ?? 0;
  }
}

class FollowersFollowings extends BaseWidget<FollowersFollowingsVM> {
  final int? tabIndex;

  FollowersFollowings({this.tabIndex = 0, super.key});

  @override
  State<BaseWidget<BaseViewModel>> createState() => _FollowersFollowingsState();

  @override
  Widget buildUI(BuildContext context, FollowersFollowingsVM viewModel) {
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
            spaceY(extra: 14),
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
                  SearchableFollowerList(
                      title: "Followers",
                      userList: viewModel.followers,
                      userItem: (user) => UserFollowerItem(
                          user: user,
                          onRemove: (userId, _) {
                            viewModel.removeFollower(userId);
                          }),
                      onSearch: (search) {
                        viewModel.searchFollowers(search: search);
                      }),
                  SearchableUserList(
                      title: "Followings",
                      userList: viewModel.followings,
                      userItem: (user) => UserFollowingItem(
                          user: user,
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
