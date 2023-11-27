import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:jpshua/components/ActiveGoalsView.dart';
import 'package:jpshua/screen/edit_profile.dart';
import 'package:jpshua/screen/followers_followings.dart';
import 'package:jpshua/screen/create_or_edit_goal.dart';
import 'package:jpshua/screen/past_goal_summary.dart';
import 'package:jpshua/screen/setting.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/view_model/followers_followings_vm.dart';
import 'package:jpshua/widgets/atom/button.dart';
import 'package:jpshua/widgets/user_avatar.dart';
import 'package:provider/provider.dart';
import '../components/PastGoalsView.dart';
import '../utils/session_key.dart';
import '../view_model/profile_vm.dart';
import '../widgets/base_widget.dart';
import 'all_active_goal.dart';

class Profile extends BaseWidget<ProfileVM> {
  Profile({super.key, this.onBackPressed});

  final Function()? onBackPressed;
  late FollowersFollowingsVM followersFollowingsVM;

  @override
  void beforeInitState(BuildContext context, ProfileVM vm) {
    HiveUtils.addSession(
        SessionKey.selectedUserId, HiveUtils.getSession(SessionKey.userId));
    followersFollowingsVM = context.read<FollowersFollowingsVM>();
    followersFollowingsVM.setContext(context);
  }

  @override
  Widget buildUI(BuildContext context, ProfileVM viewModel) {
    followersFollowingsVM = context.watch<FollowersFollowingsVM>();
    return FocusDetector(
        onFocusGained: () {
          followersFollowingsVM.initView();
          viewModel.initView();
        },
        child: SafeArea(
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
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  UserAvatar(
                    profileImg: viewModel.profileImg,
                    userName: viewModel.name,
                    fontSize: 65,
                  ),
                  spaceY(extra: 12),
                  Text(viewModel.name,
                      style: TextStyle(
                          fontSize: 16,
                          color: context.theme.onPrimary,
                          fontWeight: FontWeight.w500)),
                  Text("@${viewModel.userName}",
                      style: TextStyle(
                        fontSize: 14,
                        color: context.theme.onSecondary,
                      )),
                  spaceY(extra: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildVerticalTextButton('Followers',
                          followersFollowingsVM.followersCount.toString(),
                          onPressed: () {
                        context.push(FollowersFollowings());
                      }),
                      spaceX(extra: 30),
                      _buildVerticalTextButton("Followings",
                          followersFollowingsVM.followingsCount.toString(),
                          onPressed: () {
                        context.push(FollowersFollowings(tabIndex: 1));
                      }),
                      spaceX(extra: 40),
                      _buildVerticalTextButton(
                          "Goals", viewModel.activeGoal.length.toString(),
                          onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => AllActiveGoals(
                                  goals: viewModel.activeGoal,
                                )));
                      }),
                    ],
                  ),
                  spaceY(extra: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Edit Profile',
                        onClick: () {
                          context.push(const EditProfile());
                        },
                      ),
                      spaceX(extra: 12.0),
                      Button(
                        text: 'Add Goal',
                        onClick: () {
                          context.push(const CreateOrEditGoal());
                        },
                      ),
                    ],
                  ),
                  spaceY(extra: 28),
                  Text(
                    viewModel.bio,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  spaceY(extra: 33),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTabButton(
                          () {
                            viewModel.tabPage = 0;
                            viewModel.pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut);
                            viewModel.getActiveGoal("activeGoal");
                          },
                          'Active Goals',
                          viewModel.tabPage == 0,
                        ),
                        _buildTabButton(
                          () {
                            viewModel.tabPage = 1;
                            viewModel.pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut);
                            viewModel.getActiveGoal("pastGoal");
                          },
                          'Past Goals',
                          viewModel.tabPage == 1,
                        ),
                      ],
                    ),
                  ),
                  spaceY(extra: 5),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: viewModel.pageController,
                      children: [
                        ActiveGoalsView(
                            goalsList: viewModel.activeGoal.length > 3
                                ? viewModel.activeGoal.sublist(0, 3)
                                : viewModel.activeGoal,
                            onGoalTapped: (String goalId) {
                              HiveUtils.addSession(
                                  SessionKey.activityId, goalId);
                              context.push(const GoalSummary(title: "Summary"));
                            },
                            onViewAllGoalsTapped: () {
                              context.push(
                                  AllActiveGoals(goals: viewModel.activeGoal));
                            },
                            onAddToPastGoals: () {},
                            onDelete: (goalId) {
                              if (goalId != null) {
                                viewModel.deleteGoal(goalId);
                              }
                            }),
                        PastGoalsView(
                          pastGoalsList: viewModel.activeGoal,
                          onGoalTapped: (String goalId) {
                            HiveUtils.addSession(SessionKey.activityId, goalId);
                            context.push(GoalSummary(title: "Summary"));
                          },
                          onViewAllGoalsTapped: () {
                            // TODO: context.push(const AllPastGoals());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildTabButton(Function()? onClicked, String text, bool isSelected) {
    return InkWell(
      onTap: onClicked,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(isSelected ? 0xFF4576D6 : 0xFF808080),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
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
