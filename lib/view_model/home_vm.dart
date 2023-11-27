import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jpshua/model/post_model.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:provider/provider.dart';
import '../model/friend_model.dart';
import '../screen/push/platform_specific/android.dart';
import '../utils/appStrings.dart';

class HomeVM extends BaseViewModel {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  int _tabPage = 0;
  late PageController pageController;
  bool _loading = false;
  String? _profileImg;
  int goalCount = 0;
  int duepost = 0;
  int page = 1;
  String message = "";
  bool _isNoData = false;
  get profileImg => _profileImg;
  get loading => _loading;
  set profileImg(value) {
    _profileImg = value;
    notifyListeners();
  }

  List<PostModel> posts = [];
  bool get isNoData => _isNoData;
  ScrollController scrollController = ScrollController();

  set isNoData(bool value) {
    _isNoData = value;
  }

  void getGoal() {
    call(
      path: "user/totalDuePost",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['result'] != null) {
          duepost = object['result']['duepost'];
        }
        notifyListeners();
      },
      method: Method.get,
      isShowLoader: false,
    );
  }

  @override
  initView() {
    _isNoData = false;
    // getGoal();
    postList();
    _profileImg = HiveUtils.getSession<String>(SessionKey.image) != "null"
        ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
        : "";
    goalCount = HiveUtils.getSession<int>(SessionKey.goalCount);
    pageController = PageController(initialPage: 0);
    _tabPage = 0;
    firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    initializeFlutterLocalNotifications().then((value) {
      flutterLocalNotificationsPlugin = value;
      configureFirebase(firebaseMessaging);
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (posts.length % 30 == 0) {
          page++;
          postList();
        }
      }
    });
    return super.initView();
  }

  int get tabPage => _tabPage;

  set tabPage(int value) {
    _tabPage = value;
    notifyListeners();
  }

  @override
  disposeView() {
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(0);
    }
    return super.disposeView();
  }

  void postList() {
    posts.clear();
    _loading = true;
    notifyListeners();
    call(
        path: "Activity/getFriendsActivity",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          if (object['result'] != null) {
            posts = (object['result'] as List<dynamic>)
                .map((v) => PostModel.fromJson(v))
                .toList();
            if (posts.isEmpty) {
              page = (page == 1) ? page : page--;
            }
          }
          if (posts.isEmpty) {
            message = object['message'];
            _isNoData = true;
          } else {
            _isNoData = false;
          }
          _loading = false;
          notifyListeners();
        },
        method: Method.get,
        isShowLoader: false,
        queryParameters: {
          "page": page.toString(),
        });
  }

  BottomBarVM() {
    pageController = PageController(initialPage: 0);
  }

  void setPage(int page) {
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(page);
    }
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    if (message.notification != null) {
      displayForegroundNotification(message.notification!);
    }
    print("Handling a background message: ${message.messageId}");
  }

  void configureFirebase(FirebaseMessaging firebaseMessaging) {
    try {
      FirebaseMessaging.onMessage.listen(
        (message) {
          if (message.notification != null) {
            displayForegroundNotification(message.notification!);
          }
          if (context.mounted) {
            HomeVM homeVMVM = context.read<HomeVM>();
            // bottomBarVM.socket.emit(
            //     "countUnreadNotification", toUnreadUserJson());
          }
        },
      );
      FirebaseMessaging.onMessageOpenedApp.listen(
        (event) {
          Map body = jsonDecode(event.notification!.body ?? "");
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void displayForegroundNotification(RemoteNotification notification) async {
    var androidOptions =
        AndroidNotificationDetails(debugChannel.id, debugChannel.name,
            channelDescription: debugChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            ticker: "A manually-sent push notification.",
            styleInformation: const DefaultStyleInformation(
              false,
              false,
            ));
    const iosOptions = DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    var platformChannelSpecifics =
        NotificationDetails(android: androidOptions, iOS: iosOptions);
    await flutterLocalNotificationsPlugin!
        .show(0, notification.title, "", platformChannelSpecifics);
  }

  Future<FlutterLocalNotificationsPlugin>
      initializeFlutterLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // 'mipmap/ic_launcher' taken from https://github.com/MaikuB/flutter_local_notifications/issues/32#issuecomment-389542800
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    return flutterLocalNotificationsPlugin;
  }
}
