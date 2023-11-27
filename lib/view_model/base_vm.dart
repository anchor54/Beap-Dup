import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jpshua/utils/constants.dart';

import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../widgets/progress.dart';

abstract class BaseViewModel extends ChangeNotifier {
  late BuildContext context;

  setContext(BuildContext mContext) {
    context = mContext;
  }

  initView() {}

  initAnimation(TickerProvider provider) {}
  disposeView() {}
  static ProgressDialog progressDialog = ProgressDialog();
  callMap(
      {String host = "10.0.2.2:9000",
      required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? params,
      Map<String, String>? headers,
      Method method = Method.get,
      bool isShowLoader = false,
      required Function(int statusCode, String data) onSuccess}) {
    if (isShowLoader) {
      progressDialog.showProgressDialog(context);
    }
    var url = Uri.https(Constants.BASE_URL, "api/$path", queryParameters);
    log(url.toString());
    ////////
    var request = http.Request(method.value, url);
    print("PARAM::${params.toString()}");
    // request.bodyFields = params ?? {};
    request.body = jsonEncode(params);
    if (headers != null) {
      headers.putIfAbsent("content-type", () => "application/json");
      request.headers.addAll(headers);
    } else {
      Map<String, String> defaultHeader = {'content-type': "application/json"};
      request.headers.addAll(defaultHeader);
    }
    if (HiveUtils.getSession<String>(SessionKey.token, defaultValue: "")
        .isNotEmpty) {
      request.headers.putIfAbsent(
          "token",
          () =>
              HiveUtils.getSession<String>(SessionKey.token, defaultValue: ""));
      print(HiveUtils.getSession<String>(SessionKey.token, defaultValue: ""));
    }
    request.send().then((response) {
      if (isShowLoader) {
        progressDialog.dismissProgressDialog(context);
      }
      response.stream.bytesToString().then((data) {
        log("RES:::$data");
        log("RES_CODE:::${response.statusCode}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          onSuccess(response.statusCode, data);
        } else if (response.statusCode == 422) {
          Map object = jsonDecode(data);
          if (object['errors'] != null) {
            object['errors'].forEach((v) {
              Fluttertoast.showToast(
                msg: v,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            });
          } else if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else if (response.statusCode == 404) {
          Map object = jsonDecode(data);
          if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else if (response.statusCode == 403) {
          Map object = jsonDecode(data);
          if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: jsonDecode(data)['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
    });
  }
  // 68.178.168.170:9000

  call(
      {String host = "10.0.2.2:9000",
      required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? params,
      Map<String, String>? headers,
      Method method = Method.get,
      bool isShowLoader = false,
      required Function(int statusCode, String data) onSuccess}) {
    if (isShowLoader) {
      progressDialog.showProgressDialog(context);
    }
    var url = Uri.https(Constants.BASE_URL, "api/$path", queryParameters);
    log(url.toString());
    ////////
    var request = http.Request(method.value, url);
    print("PARAM::${params.toString()}");
    print("METHOD::${method.value}");
    request.bodyFields = params ?? {};
    // request.body = jsonEncode(params);
    if (headers != null) {
      headers.putIfAbsent(
          "content-type", () => "application/x-www-form-urlencoded");
      request.headers.addAll(headers);
    } else {
      Map<String, String> defaultHeader = {
        'content-type': "application/x-www-form-urlencoded"
      };
      request.headers.addAll(defaultHeader);
    }
    if (HiveUtils.getSession<String>(SessionKey.token, defaultValue: "")
        .isNotEmpty) {
      request.headers.putIfAbsent(
          "token",
          () =>
              HiveUtils.getSession<String>(SessionKey.token, defaultValue: ""));
      print(HiveUtils.getSession<String>(SessionKey.token, defaultValue: ""));
    }
    request.send().then((response) {
      if (isShowLoader) {
        progressDialog.dismissProgressDialog(context);
      }
      response.stream.bytesToString().then((data) {
        log("RES:::$data");
        log("RES_CODE:::${response.statusCode}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          onSuccess(response.statusCode, data);
        } else if (response.statusCode == 422) {
          Map object = jsonDecode(data);
          if (object['errors'] != null) {
            object['errors'].forEach((v) {
              Fluttertoast.showToast(
                msg: v,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            });
          } else if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else if (response.statusCode == 404) {
          Map object = jsonDecode(data);
          if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else if (response.statusCode == 403) {
          Map object = jsonDecode(data);
          if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: jsonDecode(data)['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
    });
  }

  callContact(
      {String host = "10.0.2.2:9000",
      required String path,
      Map<String, dynamic>? queryParameters,
      dynamic params,
      Map<String, String>? headers,
      Method method = Method.get,
      bool isShowLoader = false,
      required Function(int statusCode, String data) onSuccess}) {
    if (isShowLoader) {
      progressDialog.showProgressDialog(context);
    }
    var url = Uri.https(Constants.BASE_URL, "api/$path", queryParameters);
    log(url.toString());
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 5);
    ////////
    var request = http.Request(method.value, url);
    log("PARAM::${params}");
    if (params is String) {
      request.body = params;
    } else if (params is Map<String, String>) {
      request.bodyFields = params;
    }
    if (headers != null) {
      if (params is String) {
        headers.putIfAbsent("content-type", () => "application/json");
      } else {
        headers.putIfAbsent(
            "content-type", () => "application/x-www-form-urlencoded");
      }
      request.headers.addAll(headers);
    } else {
      Map<String, String> defaultHeader = {};
      if (params is String) {
        defaultHeader.putIfAbsent("content-type", () => "application/json");
      } else {
        defaultHeader.putIfAbsent(
            "content-type", () => "application/x-www-form-urlencoded");
      }
      request.headers.addAll(defaultHeader);
    }
    if (HiveUtils.getSession<String>(SessionKey.token, defaultValue: "")
        .isNotEmpty) {
      request.headers.putIfAbsent(
          "token",
          () =>
              HiveUtils.getSession<String>(SessionKey.token, defaultValue: ""));
      print(HiveUtils.getSession<String>(SessionKey.token, defaultValue: ""));
    }
    request.send().then((response) {
      if (isShowLoader) {
        progressDialog.dismissProgressDialog(context);
      }
      response.stream.bytesToString().then((data) {
        log("RES:::$data");
        log("RES_CODE:::${response.statusCode}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          onSuccess(response.statusCode, data);
        } else if (response.statusCode == 422) {
          Map object = jsonDecode(data);
          if (object['errors'] != null) {
            object['errors'].forEach((v) {
              Fluttertoast.showToast(
                msg: v,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            });
          } else if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else if (response.statusCode == 404) {
          Map object = jsonDecode(data);
          if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else if (response.statusCode == 403) {
          Map object = jsonDecode(data);
          if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: jsonDecode(data)['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
    });
  }

  callMultiPart(
      {String host = "10.0.2.2:9000",
      required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? params,
      Map<String, String>? headers,
      Method method = Method.get,
      File? file,
      String fileKey = "",
      bool isShowLoader = false,
      required Function(int statusCode, String data) onSuccess}) {
    if (isShowLoader) {
      progressDialog.showProgressDialog(context);
    }
    var url = Uri.https(Constants.BASE_URL, "api/$path", queryParameters);
    log(url.toString());
    ////////
    var request = http.MultipartRequest(method.value, url);
    print("PARAM::${params.toString()}");
    request.fields.addAll(params ?? {});
    if (file != null) {
      print("---------file---------${file.path.split('/').last}");
      request.files.add(
        http.MultipartFile(
          fileKey,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );
    }
    if (headers != null) {
      headers.putIfAbsent("content-type", () => "multipart/form-data");
      request.headers.addAll(headers);
    } else {
      Map<String, String> defaultHeader = {
        'content-type': "multipart/form-data"
      };
      request.headers.addAll(defaultHeader);
    }
    if (HiveUtils.getSession<String>(SessionKey.token, defaultValue: "")
        .isNotEmpty) {
      request.headers.putIfAbsent(
          "token",
          () =>
              HiveUtils.getSession<String>(SessionKey.token, defaultValue: ""));
    }
    request.send().then((response) {
      if (isShowLoader) {
        progressDialog.dismissProgressDialog(context);
      }
      response.stream.bytesToString().then((data) {
        log("RES:::$data");
        if (response.statusCode < 400) {
          onSuccess(response.statusCode, data);
        } else if (response.statusCode == 422) {
          Map object = jsonDecode(data);
          if (object['errors'] != null) {
            object['errors'].forEach((v) {
              Fluttertoast.showToast(
                msg: v,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            });
          }
        } else if (response.statusCode == 404) {
          Map object = jsonDecode(data);
          if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else if (response.statusCode == 403) {
          Map object = jsonDecode(data);
          if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: jsonDecode(data)['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
    });
  }
}

enum Method { post, get, delete, patch, put }

extension MethodValue on Method {
  String get value {
    switch (this) {
      case Method.post:
        return 'POST';
      case Method.get:
        return 'GET';
      case Method.delete:
        return 'DELETE';
      case Method.patch:
        return 'PATCH';
      case Method.put:
        return 'PUT';
      default:
        return "";
    }
  }
}
