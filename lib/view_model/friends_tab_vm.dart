import 'dart:convert';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:jpshua/model/get_sent_request_model.dart';
import 'package:jpshua/utils/appStrings.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';
import '../constants/Toasty.dart';
import '../model/my_contact_model.dart';
import '../model/sent_request_model.dart';
import '../model/user_sugesstion_model.dart';
import '../utils/hive_utils.dart';

class FriendTabVM extends BaseViewModel {
  var searchController = TextEditingController();
  // List<Contact> contacts = [];
  List<PhoneDetails> phoneContact = [];
  List<OnAddScreen> onAddScreen = [];
  List<OnInvite> onInvite = [];
  List<SentRequestModel> sendRequest = [];
  List<SentRequestModel> getFriendRequest = [];
  List<SendRequest> friendList = [];
  List<UserSugesstionModel> searchList = [];

  bool get isCallNoData => _isCallNoData;

  set isCallNoData(bool value) {
    _isCallNoData = value;
    notifyListeners();
  }

  int page = 1;
  String? _profileImg;
  get profileImg => _profileImg;

  set profileImg(value) {
    _profileImg = value;
    notifyListeners();
  }

  void clearSearch() {
    searchList = [];
    searchController.text = "";
    notifyListeners();
  }

  @override
  disposeView() {
    // contacts.clear();
    phoneContact.clear();
    return super.disposeView();
  }

  bool _isNoData = false;
  bool _isNoSendData = false;
  bool _isNoSearchData = false;
  bool _isNoFriendData = false;
  bool _isNoFriend = false;
  bool _isCallNoData = true;
  bool _isNoContact = false;
  int contactPos = 0;
  String path = "";
  bool get isNoContact => _isNoContact;
  bool get isNoData => _isNoData;

  set isNoData(bool value) {
    _isNoData = value;
  }

  bool get isNoSearchData => _isNoSearchData;

  set isNoSearchData(bool value) {
    _isNoSearchData = value;
  }

  bool get isNoSendData => _isNoSendData;

  set isNoSendData(bool value) {
    _isNoSendData = value;
  }

  bool get isNoFriendData => _isNoFriendData;

  set isNoFriendData(bool value) {
    _isNoData = value;
  }

  bool get isNoFriend => _isNoFriend;

  set isNoFriend(bool value) {
    _isNoFriend = value;
  }

  set isNoContact(bool value) {
    _isNoContact = value;
  }

  int _tabPage = 0;
  int _status = 0;
  PageController pageController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();

  @override
  initView() {
    _isNoData = false;
    _isNoFriend = false;
    _isNoFriendData = false;
    _isNoSendData = false;
    _isNoSearchData = false;
    onInvite = [];
    searchList = [];
    searchController.clear();
    _profileImg = HiveUtils.getSession<String>(SessionKey.image) != "null"
        ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
        : "";
    friendsList();
    // getContact();
    //   scrollController.addListener(() {
    //   if (scrollController.position.maxScrollExtent ==
    //       scrollController.position.pixels) {
    //     if(searchList.length % 30 == 0) {
    //       page++;
    //       getFriendSugesstion();
    //     }
    //   }
    // });
    pageController = PageController(initialPage: 0);
    _tabPage = 0;
    _status = 0;
    return super.initView();
  }

  int get tabPage => _tabPage;

  set tabPage(int value) {
    _tabPage = value;
    notifyListeners();
  }

  int get status => _status;

  set status(int value) {
    _status = value;
    notifyListeners();
  }

  // void getContact() async {
  //   if (await FlutterContacts.requestPermission()) {
  //     contacts = await FlutterContacts.getContacts(
  //         withProperties: true, withPhoto: true, withAccounts: true);
  //     print("object$contacts");
  //     for (var i = 0;
  //     i < (contacts.length > 150 ? 150 : contacts.length);
  //     i++) {
  //       if (contacts[i].phones.isNotEmpty &&
  //           contacts[i].phones[0].number.length > 10) {
  //         String mobileNum = contacts[i].phones[0].number.substring(1);
  //         String mobile =
  //         mobileNum.substring(mobileNum.length - 10, mobileNum.length);
  //         String countryCode = mobileNum.substring(0, mobileNum.length - 10);
  //         phoneContact.add(PhoneDetails(
  //             contactName: contacts[i].displayName.toString(),
  //             mobileNo: mobile,
  //             countryCode: countryCode));
  //         notifyListeners();
  //       }
  //     }
  //     contactPos = 150;
  //     getFeedData(phoneContact);
  //   }
  // }
  // void getFeedData(contactList) {
  //   onInvite.clear();
  //   print("----------feed data------");
  //   callContact(
  //       path: "user/myContact",
  //       onSuccess: (statusCode, data) {
  //         Map object = jsonDecode(data);
  //         MyContact myContact = MyContact.fromJson(object['result']);
  //         onAddScreen = myContact.onAddScreen ?? [];
  //         onInvite = myContact.onInvite ?? [];
  //         notifyListeners();
  //         // getNextContact();
  //         if (onAddScreen.isEmpty) {
  //           _isNoData = true;
  //         } else {
  //           _isNoData = false;
  //         }
  //         if (onInvite.isEmpty) {
  //           _isNoContact = true;
  //         } else {
  //           _isNoContact = false;
  //         }
  //       },
  //       method: Method.post,
  //       isShowLoader: false,
  //       params: jsonEncode({"contacts": contactList}));
  // }
  void getSendFriendsRequest() {
    sendRequest.clear();
    callContact(
        path: "friends/getSentFriendRequests",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          if (object['result'] != null) {
            object['result'].forEach((v) {
              sendRequest.add(SentRequestModel.fromJson(v));
            });
          }
          if (sendRequest.isEmpty) {
            _isNoSendData = true;
          } else {
            _isNoSendData = false;
          }
          notifyListeners();
        },
        method: Method.get,
        isShowLoader: false,
        queryParameters: {
          "senderId":
              HiveUtils.getSession<String>(SessionKey.userId, defaultValue: ""),
        });
  }

  void getFriendSugesstion() {
    searchList.clear();
    callContact(
        path: "user/username-suggestion",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          if (object['result'] != null) {
            object['result'].forEach((v) {
              searchList.add(UserSugesstionModel.fromJson(v));
            });
          }
          if (searchList.isEmpty) {
            _isNoSearchData = true;
          } else {
            _isNoSearchData = false;
          }
          if (searchList.isEmpty) {
            page = (page == 1) ? page : page--;
          }
          notifyListeners();
        },
        method: Method.get,
        isShowLoader: false,
        queryParameters: {
          "page": page.toString(),
          "size": "10",
          "search": searchController.text
        });
  }

  // void getNextContact() {
  //   print("------next-contact-----");
  //   phoneContact.clear();
  //   for (var i = contactPos; i < (contacts.length > (contactPos + 150) ? (contactPos + 150) : (contacts.length-contactPos)); i++) {
  //     if (contacts[i].phones.isNotEmpty &&
  //         contacts[i].phones[0].normalizedNumber.length > 10) {
  //       String mobileNum =
  //       contacts[i].phones[0].normalizedNumber.substring(1);
  //       String mobile =
  //       mobileNum.substring(mobileNum.length - 10, mobileNum.length);
  //       String countryCode = mobileNum.substring(0, mobileNum.length - 10);
  //       phoneContact.add(PhoneDetails(
  //           contactName: contacts[i].displayName.toString(),
  //           mobileNo: mobile,
  //           countryCode: countryCode));
  //     }
  //   }
  //   if(phoneContact.isNotEmpty) {
  //     contactPos = contactPos + 150;
  //     getFeedData(phoneContact);
  //   }else{
  //     isCallNoData = false;
  //   }
  // }
  void sendFriendRequest(index) {
    call(
      path: "friends/friendrequest",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['success'] = true) {
          searchList[index].friend != null
              ? searchList[index].friend!.status = "pending"
              : getFriendSugesstion();
          // if(searchList[index].friend==null){
          //   searchList[index].friend=object["result"];
          //   searchList[index].friend!.status="pending";
          //
          // }else{
          //   searchList[index].friend!.status="pending";
          // }
        }
        notifyListeners();
      },
      method: Method.post,
      isShowLoader: true,
      params: {
        "senderId":
            HiveUtils.getSession<String>(SessionKey.userId, defaultValue: ""),
        "recipientId": HiveUtils.getSession<String>(SessionKey.recipientId,
            defaultValue: "")
      },
    );
  }

  void deleteFriendRequest(index, mobilenum) {
    call(
      path: "user/remove-myContact-suggestion",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['success'] = true) {
          // Toasty.showtoast(object['message']);
          onAddScreen.removeAt(index);
        }
        notifyListeners();
      },
      method: Method.post,
      isShowLoader: true,
      params: {
        "mobile": mobilenum.toString(),
      },
    );
  }

  void sendInivition(invitedToMobile, index) {
    call(
      path: "user/inviteUser",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['success'] = true) {
          onInvite[index].invited = true;
          // Toasty.showtoast(object['message']);
        }
        notifyListeners();
      },
      method: Method.post,
      isShowLoader: true,
      params: {"invitedToMobile": invitedToMobile.toString()},
    );
  }

  void friendsRequest() {
    getFriendRequest.clear();
    callContact(
        path: "friends/pendingFriendRequest",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          if (object['result'] != null) {
            object['result'].forEach((v) {
              getFriendRequest.add(SentRequestModel.fromJson(v));
            });
          }
          if (getFriendRequest.isEmpty) {
            _isNoFriendData = true;
          } else {
            _isNoFriendData = false;
          }

          notifyListeners();
        },
        method: Method.get,
        isShowLoader: false,
        queryParameters: {
          "userId":
              HiveUtils.getSession<String>(SessionKey.userId, defaultValue: ""),
        });
  }

  void friendsList() {
    friendList.clear();
    callContact(
        path: "friends/friendList",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          if (object['result'] != null) {
            object['result'].forEach((v) {
              friendList.add(SendRequest.fromJson(v));
            });
          }
          if (friendList.isEmpty) {
            _isNoFriend = true;
          } else {
            _isNoFriend = false;
          }
          notifyListeners();
        },
        method: Method.get,
        isShowLoader: false,
        queryParameters: {
          "userId":
              HiveUtils.getSession<String>(SessionKey.userId, defaultValue: ""),
        });
  }

  void acceptRequest(index, status, list) {
    call(
      path: "friends/acceptOrRejectFriendRequest",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['success'] = true) {
          // Toasty.showtoast(object['message']);
          list.removeAt(index);
        }
        notifyListeners();
      },
      method: Method.put,
      isShowLoader: true,
      queryParameters: {
        "sender": HiveUtils.getSession<String>(SessionKey.recipientId,
            defaultValue: ""),
        "status": status.toString(),
      },
    );
  }

  void unFriendRequest(index) {
    call(
      path: "friends/unfriend",
      onSuccess: (statusCode, data) {
        Map object = jsonDecode(data);
        if (object['success'] = true) {
          // Toasty.showtoast(object['message']);
          friendList.removeAt(index);
        }
        notifyListeners();
      },
      method: Method.post,
      isShowLoader: true,
      queryParameters: {
        "unfriendUserId": HiveUtils.getSession<String>(SessionKey.recipientId,
            defaultValue: ""),
      },
    );
  }
}

class PhoneDetails {
  String contactName = "";
  String mobileNo = "";
  String countryCode = "";

  PhoneDetails(
      {required this.contactName,
      required this.mobileNo,
      required this.countryCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contactname'] = contactName;
    data['mobile_no'] = mobileNo;
    data['country_code'] = countryCode;
    return data;
  }
}
