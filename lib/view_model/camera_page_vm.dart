import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:jpshua/view_model/base_vm.dart';

class CameraPageVM extends BaseViewModel{
  late final List<CameraDescription>? cameras;
  late CameraController cameraController;
  bool _isRearCameraSelected = true;

  bool get rememberCheck => _isRearCameraSelected;

  set rememberCheck(bool value) {
    _isRearCameraSelected = !_isRearCameraSelected;
    // _isRearCameraSelected = value;
    // initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
    notifyListeners();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  initView() {
    initCamera(cameras![0]);
    return super.initView();
  }

   takePicture() async {
    if (!cameraController.value.isInitialized) {
      return null;
    }
    if (cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await cameraController.setFlashMode(FlashMode.off);
      XFile picture = await cameraController.takePicture();
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => PreviewPage(
      //           picture: picture,
      //         )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await cameraController.initialize().then((_) {
        notifyListeners();
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

}