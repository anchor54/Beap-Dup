import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/home_vm.dart';
import 'package:jpshua/view_model/profile_vm.dart';
import 'package:jpshua/view_model/setting_vm.dart';
import 'package:provider/provider.dart';

import '../constants/Toasty.dart';
import '../constants/my_theme.dart';
import '../screen/base_home.dart';
import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';

class EditProfileVM extends BaseViewModel {
  File? imageFile;
  bool _isValidUserName = false;
  String message = "", isStatus = "";
  final ImagePicker picker = ImagePicker();
  var filePath, name, userName;
  final formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  late SettingVM settingVm;
  late HomeVM homeVm;
  late ProfileVM profileVm;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }

  String? _profileImg;
  get profileImg => _profileImg;

  set profileImg(value) {
    _profileImg = value;
    notifyListeners();
  }

  @override
  initView() {
    settingVm = context.read<SettingVM>();
    homeVm = context.read<HomeVM>();
    profileVm = context.read<ProfileVM>();
    getUserDetail();
    return super.initView();
  }

  getUserDetail() {
    nameController.text =
        HiveUtils.getSession<String>(SessionKey.name, defaultValue: "");
    usernameController.text =
        HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "");
    HiveUtils.getSession<String>(SessionKey.bio) != "null"
        ? bioController.text = HiveUtils.getSession<String>(SessionKey.bio)
        : "";
    name = HiveUtils.getSession<String>(SessionKey.name, defaultValue: "");
    userName =
        HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "");
    _profileImg = HiveUtils.getSession<String>(SessionKey.image) != "null"
        ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
        : "";
  }

  bool get isValidUserName => _isValidUserName;

  set isValidUserName(bool value) {
    _isValidUserName = value;
    notifyListeners();
  }

  void goToRegister() {
    _isValidUserName = false;
    FocusScope.of(context).unfocus();
    formKey.currentState!.save();
    goCheckUserName();
  }

  void goCheckUserName() {
    if (usernameController.text.isNotEmpty) {
      call(
        path: "user/checkUserName",
        queryParameters: {
          'userName': usernameController.text.toString(),
        },
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          isStatus = object["isStatus"].toString();
          isValidUserName = object["isStatus"] == 1;
          if (!isValidUserName) {
            print(isValidUserName);
            print("----if-----");
            message = object["message"].toString();
            notifyListeners();
          } else {
            print("--else----");
            message = object["message"].toString();
            notifyListeners();
          }
          if (message == "Verifed") {
            updateUserName();
          }
        },
        method: Method.post,
      );
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }

  Future<File> _cropImage(File profileImageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: profileImageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: MyColor.primary,
              toolbarWidgetColor: MyColor.onPrimary,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          )
        ]);
    return File(croppedFile!.path);
  }

  getImgCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      imageFile = File(photo.path);
      filePath = photo.path;
      print("file:: $filePath");
      _cropImage(File(photo.path)).then((value) async {
        print("Cropfile:: $filePath");

        // final bytes = File(photo.path).readAsBytesSync();
      });
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'No File Selected');
    }
  }

  getImgGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      filePath = image.path;
      print("file:: $filePath");
      print("imageFile:: $imageFile");
      print(filePath.split("image_picker").last);
      _cropImage(File(image.path)).then((value) async {
        filePath = value.path;
        print("Cropfile:: $filePath");
        if (filePath != null) {
          profilePicker();
        }
        // final bytes = File(image.path).readAsBytesSync();
      });
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'No File Selected');
    }
  }

  void profilePicker() {
    callMultiPart(
        path: "user/updateRestUserInfromation",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          // Toasty.showtoast( object['message']);
          HiveUtils.addSession(
              SessionKey.image, object['result']['image'].toString());
          homeVm.profileImg =
              HiveUtils.getSession<String>(SessionKey.image) != "null"
                  ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
                  : "";
          settingVm.profileImg =
              HiveUtils.getSession<String>(SessionKey.image) != "null"
                  ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
                  : "";
          profileVm.profileImg =
              HiveUtils.getSession<String>(SessionKey.image) != "null"
                  ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
                  : "";
          getUserDetail();
          notifyListeners();
        },
        method: Method.put,
        isShowLoader: false,
        queryParameters: {
          "userid":
              HiveUtils.getSession<String>(SessionKey.userId, defaultValue: ""),
        },
        file: filePath != null ? File(filePath) : filePath,
        fileKey: "image");
  }

  void updateFullName() {
    if (nameController.text.isNotEmpty) {
      call(
          path: "user/updateRestUserInfromation",
          onSuccess: (statusCode, data) {
            Map object = jsonDecode(data);
            // Toasty.showtoast( object['message']);
            HiveUtils.addSession(
                SessionKey.name, object['result']['name'].toString());
            getUserDetail();
            settingVm.getUserDetail();
            profileVm.getUserDetail();
            notifyListeners();
          },
          method: Method.put,
          isShowLoader: false,
          queryParameters: {
            "userid": HiveUtils.getSession<String>(SessionKey.userId,
                defaultValue: ""),
          },
          params: {
            "name": nameController.text.toString(),
          });
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }

  void updateBio() {
    if (bioController.text.isNotEmpty) {
      call(
          path: "user/updateRestUserInfromation",
          onSuccess: (statusCode, data) {
            Map object = jsonDecode(data);
            // Toasty.showtoast( object['message']);
            HiveUtils.addSession(
                SessionKey.bio, object['result']['bio'].toString());
            notifyListeners();
            getUserDetail();
          },
          method: Method.put,
          isShowLoader: false,
          queryParameters: {
            "userid": HiveUtils.getSession<String>(SessionKey.userId,
                defaultValue: ""),
          },
          params: {
            "bio": bioController.text.toString(),
          });
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }

  void updateUserName() {
    if (usernameController.text.isNotEmpty) {
      call(
          path: "user/updateRestUserInfromation",
          onSuccess: (statusCode, data) {
            Map object = jsonDecode(data);
            // Toasty.showtoast( object['message']);
            HiveUtils.addSession(
                SessionKey.userName, object['result']['userName']);
            getUserDetail();
            settingVm.getUserDetail();
            profileVm.getUserDetail();
            notifyListeners();
          },
          method: Method.put,
          isShowLoader: false,
          queryParameters: {
            "userid": HiveUtils.getSession<String>(SessionKey.userId,
                defaultValue: ""),
          },
          params: {
            "userName": usernameController.text.toString(),
          });
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }
}
