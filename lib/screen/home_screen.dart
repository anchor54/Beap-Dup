import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:jpshua/screen/Profile.dart';
import 'package:jpshua/screen/friends_tab.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/view_model/home_vm.dart';
import 'package:jpshua/widgets/appbar/home.dart';
import 'package:jpshua/widgets/base_widget.dart';
import 'package:jpshua/widgets/post_card.dart';

class HomeScreen extends BaseWidget<HomeVM> {
  @override
  Widget buildUI(BuildContext context, HomeVM viewModel) {
    return FocusDetector(
      onFocusGained: () {
        viewModel.postList();
      },
      child: Scaffold(
          backgroundColor: context.theme.primary,
          appBar: HomeAppBar(
            profileImageUrl: viewModel.profileImg,
            onFriendsTap: () {
              context.push(const FriendsTab());
            },
            onProfileTap: () {
              context.push(Profile());
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: viewModel.loading
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int i) =>
                        PostCardShimmer(),
                    separatorBuilder: (BuildContext context, int i) =>
                        spaceY(extra: 16.0),
                    itemCount: 2)
                : viewModel.posts.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () =>
                            Future.sync(() => viewModel.postList()),
                        child: ListView.separated(
                            itemBuilder: (BuildContext context, int i) =>
                                viewModel.loading
                                    ? PostCardShimmer()
                                    : PostCard(post: viewModel.posts[i]),
                            separatorBuilder: (BuildContext context, int i) =>
                                spaceY(extra: 16.0),
                            itemCount: viewModel.posts.length),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("Your Friends have not posted today",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    height: 1.2,
                                    color: context.theme.onPrimary,
                                    fontWeight: FontWeight.w500)),
                          ),
                          // spaceY(extra: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text("Add Friends",
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(
                          //             fontSize: 16,
                          //             letterSpacing: 0.2,
                          //             height: 1.2,
                          //             color: context.theme.onPrimary,
                          //             fontWeight: FontWeight.w500)),
                          //     Icon(
                          //       Icons.arrow_forward,
                          //       color: Colors.black,
                          //     )
                          //   ],
                          // )
                        ],
                      ),
          )),
    );
  }
}
