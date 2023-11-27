import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:jpshua/components/ActiveGoalsView.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/edit_profile.dart';
import 'package:jpshua/screen/followers_followings.dart';
import 'package:jpshua/screen/create_or_edit_goal.dart';
import 'package:jpshua/screen/others_followers_followings.dart';
import 'package:jpshua/screen/past_goal_summary.dart';
import 'package:jpshua/screen/setting.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/view_model/other_profile_vm.dart';
import 'package:jpshua/view_model/others_followers_followings_vm.dart';
import 'package:jpshua/widgets/atom/button.dart';
import 'package:jpshua/widgets/user_avatar.dart';
import 'package:provider/provider.dart';
import '../components/PastGoalsView.dart';
import '../utils/session_key.dart';
import '../widgets/base_widget.dart';
import 'all_active_goal.dart';

class OthersProfileScreen extends BaseWidget<OthersProfileVM> {
  OthersProfileScreen({super.key, this.onBackPressed});

  final Function()? onBackPressed;
  late OthersFollowersFollowingsVM followersFollowingsVM;

  @override
  void beforeInitState(BuildContext context, OthersProfileVM vm) {
    followersFollowingsVM = context.read<OthersFollowersFollowingsVM>();
    followersFollowingsVM.setContext(context);
  }

  @override
  Widget buildUI(BuildContext context, OthersProfileVM viewModel) {
    PageController pageController = PageController();
    return FocusDetector(
      onFocusGained: () {
        followersFollowingsVM.initView();
        viewModel.initView();
      },
      child: Scaffold(
        extendBody: false,
        backgroundColor: context.theme.primary,
        appBar: AppBar(
          backgroundColor: context.theme.primary,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                if (onBackPressed != null) {
                  onBackPressed!();
                  return;
                } else {
                  context.pop();
                }
              },
              child: Icon(
                Icons.arrow_back,
                color: context.theme.onPrimary,
              )),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                context.push(const Setting());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SvgPicture.asset("assets/svg/menu.svg"),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserAvatar(
                    profileImg: viewModel.profileImg,
                    userName: viewModel.name ?? '',
                    fontSize: 60,
                  ),
                  spaceY(extra: 12),
                  Text(viewModel.name.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: context.theme.onPrimary,
                          fontWeight: FontWeight.w500)),
                  Text("@${viewModel.userName}",
                      style: TextStyle(
                        fontSize: 14,
                        color: context.theme.onSecondary,
                      )),
                  spaceY(extra: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildVerticalTextButton("Followers",
                            followersFollowingsVM.followersCount.toString(),
                            onPressed: () {
                          context.push(OthersFollowersFollowings(
                            tabIndex: 1,
                          ));
                        }),
                        spaceX(extra: 25),
                        _buildVerticalTextButton("Followings",
                            followersFollowingsVM.followingsCount.toString(),
                            onPressed: () {
                          context.push(OthersFollowersFollowings(
                            tabIndex: 1,
                          ));
                        }),
                        spaceX(extra: 40),
                        _buildVerticalTextButton(
                            "Goals", viewModel.activeGoalsCount.toString(),
                            onPressed: () {
                          context.push(AllActiveGoals(
                              editable: false, goals: viewModel.activeGoals));
                        }),
                      ],
                    ),
                  ),
                  spaceY(extra: 14),
                  Button(
                      text: viewModel.isFollowing ? 'Following' : 'Follow',
                      onClick: () {
                        (viewModel.isFollowing)
                            ? followersFollowingsVM.unfollow(viewModel.uId,
                                callback: () {
                                viewModel.isFollowing = false;
                              })
                            : followersFollowingsVM.follow(viewModel.uId,
                                callback: () {
                                viewModel.isFollowing = true;
                              });
                      }),
                  if (viewModel.bio != null) spaceY(extra: 28),
                  Text(
                    viewModel.bio ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (viewModel.bio != null) spaceY(extra: 33),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            viewModel.tabPage = 0;
                            pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut);
                            viewModel.getActiveGoals();
                          },
                          child: Text(
                            'Active Goals',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(viewModel.tabPage == 0
                                  ? 0xFF4475D5
                                  : 0xFF808080),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.tabPage = 1;
                            pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut);
                            viewModel.getPastGoals();
                          },
                          child: Text(
                            'Past Goals',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(viewModel.tabPage == 1
                                  ? 0xFF4475D5
                                  : 0xFF808080),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  spaceY(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children: [
                          ActiveGoalsView(
                              goalsList: viewModel.activeGoalsCount > 3
                                  ? viewModel.activeGoals.sublist(0, 3)
                                  : viewModel.activeGoals,
                              onGoalTapped: (String goalId) {
                                HiveUtils.addSession(
                                    SessionKey.activityId, goalId);
                                context.push(GoalSummary(
                                  title: "Summary",
                                  editable: false,
                                ));
                              },
                              onViewAllGoalsTapped: () {
                                context.push(AllActiveGoals(
                                    editable: false,
                                    goals: viewModel.activeGoals));
                              }),
                          PastGoalsView(
                            pastGoalsList: viewModel.pastGoals,
                            onGoalTapped: (String goalId) {
                              HiveUtils.addSession(
                                  SessionKey.activityId, goalId);
                              context.push(GoalSummary(
                                title: "Summary",
                                editable: false,
                              ));
                            },
                            onViewAllGoalsTapped: () {
                              // TODO: context.push(const AllPastGoals());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildVerticalTextButton(String title, String count,
      {Function()? onPressed = null}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            count,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
