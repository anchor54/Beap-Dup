import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jpshua/utils/extensions/goto.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

import 'camera_preview.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, this.onBackPressed = null}) : super(key: key);

  final Function()? onBackPressed;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  List<CameraDescription> cameras = [];

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      setState(() {
        cameras = value;
      });
      if ((_isRearCameraSelected && value.isNotEmpty) ||
          (!_isRearCameraSelected && value.length > 1)) {
        initCamera(value[_isRearCameraSelected ? 0 : 1]);
      }
    });
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      context.push(PreviewPage(
        picture: picture,
      ));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameras.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        // floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
        backgroundColor: context.theme.onPrimary,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: InkWell(
                onTap: () {
                  if (widget.onBackPressed != null) {
                    widget.onBackPressed!();
                  } else {
                    context.pop();
                  }
                },
                child: Icon(
                  Icons.clear,
                  color: context.theme.primary,
                ))),
        body: Stack(children: [
          (_cameraController.value.isInitialized)
              ? _cameraController.buildPreview()
              : Container(
                  color: Colors.black,
                  child: const Center(child: CircularProgressIndicator())),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: context.theme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: context.theme.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: context.theme.onSecondary,
                                    width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: IconButton(
                                onPressed: takePicture,
                                iconSize: 50,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(Icons.circle,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )),
                      Expanded(
                          child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        icon: Icon(
                            _isRearCameraSelected
                                ? CupertinoIcons.switch_camera
                                : CupertinoIcons.switch_camera_solid,
                            color: Colors.white),
                        onPressed: () {
                          setState(() =>
                              _isRearCameraSelected = !_isRearCameraSelected);
                          initCamera(cameras[_isRearCameraSelected ? 0 : 1]);
                        },
                      )),
                    ])),
          ),
        ]));
  }
}
