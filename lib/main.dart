import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jpshua/screen/splash.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/view_model/account_vm.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_confirm_habit_vm.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_frequent_vm.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_start_end_date_vm.dart';
import 'package:jpshua/view_model/add_active_goal_vm/add_active_title_vm.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/confirm_habit_profile_vm.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/profile_frequent_vm.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/profile_title_vm.dart';
import 'package:jpshua/view_model/add_goal_from_profile_vm/start_end_date_profilevm.dart';
import 'package:jpshua/view_model/add_past_goal_vm/add_past_goal_confirm_habit_vm.dart';
import 'package:jpshua/view_model/add_past_goal_vm/add_past_goal_frequent_vm.dart';
import 'package:jpshua/view_model/add_past_goal_vm/add_past_goal_start_end_date_vm.dart';
import 'package:jpshua/view_model/add_past_goal_vm/add_past_title_goal_vm.dart';
import 'package:jpshua/view_model/all_goal_vm.dart';
import 'package:jpshua/view_model/all_past_goal_vm.dart';
import 'package:jpshua/view_model/back_to_login_vm.dart';
import 'package:jpshua/view_model/callendar_screen_vm.dart';
import 'package:jpshua/view_model/camera_page_vm.dart';
import 'package:jpshua/view_model/camera_preview_vm.dart';
import 'package:jpshua/view_model/confirm_habit_vm.dart';
import 'package:jpshua/view_model/custom_vm.dart';
import 'package:jpshua/view_model/dob_vm.dart';
import 'package:jpshua/view_model/edit_custom_vm.dart';
import 'package:jpshua/view_model/edit_goal_vm.dart';
import 'package:jpshua/view_model/edit_profile_vm.dart';
import 'package:jpshua/view_model/edit_repeat.dart';
import 'package:jpshua/view_model/followers_followings_vm.dart';
import 'package:jpshua/view_model/forgot_password_vm.dart';
import 'package:jpshua/view_model/frequent_vm.dart';
import 'package:jpshua/view_model/friends_tab_vm.dart';
import 'package:jpshua/view_model/home_vm.dart';
import 'package:jpshua/view_model/join_habit_vm.dart';
import 'package:jpshua/view_model/login_vm.dart';
import 'package:jpshua/view_model/create_or_edit_goal_vm.dart';
import 'package:jpshua/view_model/onboarding_screen_vm.dart';
import 'package:jpshua/view_model/other_profile_vm.dart';
import 'package:jpshua/view_model/others_followers_followings_vm.dart';
import 'package:jpshua/view_model/password_vm.dart';
import 'package:jpshua/view_model/repeat_vm.dart';
import 'package:jpshua/view_model/reset_password_vm.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import 'package:jpshua/view_model/notification_vm.dart';
import 'package:jpshua/view_model/otp_verify_vm.dart';
import 'package:jpshua/view_model/past_goal_summay_vm.dart';
import 'package:jpshua/view_model/profile_vm.dart';
import 'package:jpshua/view_model/setting_vm.dart';
import 'package:jpshua/view_model/splash_vm.dart';
import 'package:jpshua/view_model/start_end_vm.dart';
import 'package:jpshua/view_model/title_vm.dart';
import 'package:jpshua/view_model/upload_profile_picture_vm.dart';
import 'package:jpshua/view_model/username_vm.dart';
import 'package:provider/provider.dart';
import 'constants/my_theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HiveUtils.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupVM()),
        ChangeNotifierProvider(create: (context) => DobVM()),
        ChangeNotifierProvider(create: (context) => AccountVM()),
        ChangeNotifierProvider(create: (context) => OtpVM()),
        ChangeNotifierProvider(create: (context) => UserNameVM()),
        ChangeNotifierProvider(create: (context) => HomeVM()),
        ChangeNotifierProvider(create: (context) => FriendTabVM()),
        ChangeNotifierProvider(create: (context) => CameraPageVM()),
        ChangeNotifierProvider(create: (context) => CameraPreviewVM()),
        ChangeNotifierProvider(create: (context) => UploadProfilePictureVM()),
        ChangeNotifierProvider(create: (context) => ProfileVM()),
        ChangeNotifierProvider(create: (context) => SettingVM()),
        ChangeNotifierProvider(create: (context) => NotificationVM()),
        ChangeNotifierProvider(create: (context) => EditProfileVM()),
        ChangeNotifierProvider(create: (context) => TitleVM()),
        ChangeNotifierProvider(create: (context) => StartEndDateVM()),
        ChangeNotifierProvider(create: (context) => ConfirmHabitVM()),
        ChangeNotifierProvider(create: (context) => FrequentVM()),
        ChangeNotifierProvider(create: (context) => JoinHabitVM()),
        ChangeNotifierProvider(create: (context) => AllActiveGoalVM()),
        ChangeNotifierProvider(create: (context) => GoalSummaryVM()),
        ChangeNotifierProvider(create: (context) => CalendarScreenVm()),
        ChangeNotifierProvider(create: (context) => SplashVM()),
        ChangeNotifierProvider(create: (context) => LoginVM()),
        ChangeNotifierProvider(create: (context) => ForgotVM()),
        ChangeNotifierProvider(create: (context) => ResetPasswordVM()),
        ChangeNotifierProvider(create: (context) => BackToLoginVM()),
        ChangeNotifierProvider(create: (context) => PasswordVM()),
        ChangeNotifierProvider(create: (context) => TitleProfileVM()),
        ChangeNotifierProvider(create: (context) => StartEndDateProfileVM()),
        ChangeNotifierProvider(create: (context) => FrequentProfileVM()),
        ChangeNotifierProvider(create: (context) => ConfirmHabitProfileVM()),
        ChangeNotifierProvider(create: (context) => ActiveTitleVM()),
        ChangeNotifierProvider(create: (context) => ActiveStartEndDateVM()),
        ChangeNotifierProvider(create: (context) => ActiveFrequentVM()),
        ChangeNotifierProvider(create: (context) => ActiveConfirmHabitVM()),
        ChangeNotifierProvider(create: (context) => PastGoalVM()),
        ChangeNotifierProvider(create: (context) => PastConfirmHabitVM()),
        ChangeNotifierProvider(create: (context) => PastFrequentVM()),
        ChangeNotifierProvider(create: (context) => PastStartEndDateVM()),
        ChangeNotifierProvider(create: (context) => PastTitleVM()),
        ChangeNotifierProvider(create: (context) => OnboardingVM()),
        ChangeNotifierProvider(create: (context) => CreateOrEditGoalVM()),
        ChangeNotifierProvider(create: (context) => CustomVM()),
        ChangeNotifierProvider(create: (context) => RepeatVM()),
        ChangeNotifierProvider(create: (context) => EditGoalVM()),
        ChangeNotifierProvider(create: (context) => EditRepeatVM()),
        ChangeNotifierProvider(create: (context) => EditCustomVM()),
        ChangeNotifierProvider(create: (context) => FollowersFollowingsVM()),
        ChangeNotifierProvider(create: (context) => OthersProfileVM()),
        ChangeNotifierProvider(create: (context) => OthersFollowersFollowingsVM())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beap',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      home: const Splash(),
      // home:HiveUtils.getSession<bool>(SessionKey.isLoggedIn,defaultValue: false)?context.pushReplacement(const BaseHome()): context.pushReplacement(const Login()),
    );
  }
}
