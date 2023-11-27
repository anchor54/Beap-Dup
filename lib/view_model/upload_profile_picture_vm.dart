import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/screen/Signup.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/view_model/account_vm.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:jpshua/view_model/dob_vm.dart';
import 'package:jpshua/view_model/password_vm.dart';
import 'package:jpshua/view_model/signup_vm.dart';
import 'package:jpshua/view_model/username_vm.dart';
import 'package:provider/provider.dart';

import '../constants/Toasty.dart';
import '../screen/base_home.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';

class UploadProfilePictureVM extends BaseViewModel {
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  var filePath;
  final formKey = GlobalKey<FormState>();
  late SignupVM signVm;
  late PasswordVM passVm;
  late DobVM dobVm;
  late UserNameVM userVm;
  late AccountVM accVm;

  @override
  initView() {
    userVm = context.read<UserNameVM>();
    dobVm = context.read<DobVM>();
    passVm = context.read<PasswordVM>();
    signVm = context.read<SignupVM>();
    accVm = context.read<AccountVM>();
    return super.initView();
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
        // final bytes = File(image.path).readAsBytesSync();
      });
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'No File Selected');
    }
  }

  void updateUserInfo() {
    callMultiPart(
        path: "user/updateRestUserInfromation",
        onSuccess: (statusCode, data) {
          Map object = jsonDecode(data);
          // Toasty.showtoast( object['message']);
          HiveUtils.addSession(SessionKey.token, object['result']['token']);
          HiveUtils.addSession(SessionKey.name, object['result']['name']);
          HiveUtils.addSession(
              SessionKey.mobileNum, object['result']['mobile']);
          HiveUtils.addSession(SessionKey.dob, object['result']['dob']);
          HiveUtils.addSession(SessionKey.userId, object['result']['_id']);
          HiveUtils.addSession(SessionKey.isLoggedIn, true);
          HiveUtils.addSession(SessionKey.user, jsonEncode(object['result']));
          HiveUtils.addSession(
              SessionKey.image, object['result']['image'].toString());
          HiveUtils.addSession(
              SessionKey.userName, object['result']['userName']);
          context.pushReplacement(const BaseHome());
          accVm.gmailController.clear();
          passVm.passwordController.clear();
          dobVm.dobController.clear();
          userVm.usernameController.clear();
          signVm.nameController.clear();
        },
        method: Method.put,
        isShowLoader: false,
        queryParameters: {
          "userid":
              HiveUtils.getSession<String>(SessionKey.userId, defaultValue: ""),
        },
        params: {
          "userName": userVm.usernameController.text.toString(),
        },
        file: filePath != null ? File(filePath) : filePath,
        fileKey: "image");
  }
}
