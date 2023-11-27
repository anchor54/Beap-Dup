import 'package:flutter/cupertino.dart';
import 'package:jpshua/view_model/base_vm.dart';

class ForgotVM extends BaseViewModel{
  var codeController = TextEditingController();
  final GlobalKey<FormState> forgetKey = GlobalKey<FormState>();

}