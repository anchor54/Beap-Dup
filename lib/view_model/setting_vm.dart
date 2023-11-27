import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/view_model/base_vm.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../utils/appStrings.dart';
import '../utils/hive_utils.dart';

class SettingVM extends BaseViewModel{
  var  filePath,name,userName;
  String? _profileImg;
  get profileImg => _profileImg;

  set profileImg(value) {
    _profileImg = value;
    notifyListeners();
  }
  @override
  initView() {
    _profileImg=HiveUtils.getSession<String>(SessionKey.image)!="null"?"$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}":"";
    name=HiveUtils.getSession<String>(SessionKey.name, defaultValue: "");
    userName=HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "");
    return super.initView();
  }
  getUserDetail(){
    name=HiveUtils.getSession<String>(SessionKey.name, defaultValue: "");
    userName=HiveUtils.getSession<String>(SessionKey.userName, defaultValue: "");
    notifyListeners();
  }

}