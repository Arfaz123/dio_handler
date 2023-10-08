import 'dart:convert';
import 'dart:js';
import 'package:dio_handler/src/loading_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class APIService {
  static const String somethingWrong = "Something Went Wrong";
  static const String responseMessage = "NO RESPONSE DATA FOUND";
  static const String interNetMessage =
      "No internet connection, Please check your internet connection and try again later";
  static const String connectionTimeOutMessage =
      "Oops.. Server not working or might be in maintenance. Please Try Again Later";
  static const String authenticationMessage =
      "The session has been Expired. Please log in again.";
  static const String tryAgain = "Try Again";

  static const String getMethod = "getMethod";
  static const String postMethod = "postMethod";
  static const String putMethod = "putMethod";
  static const String deleteMethod = "deleteMethod";
  static const String token = "deleteMethod";

  final d.Dio dio = d.Dio(d.BaseOptions(
      baseUrl: "",
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      validateStatus: (code) {
        if (code == 200 || code == 201) {
          return true;
        } else {
          return false;
        }
      }));

  Future callAPI(
      {Map<String, dynamic>? params,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? body,
        required String serviceUrl,
        required String method,
        d.FormData? formDatas,
        required Function success,
        required Function error,
        required bool showProcess}) async {
    if (headers == null || headers.isEmpty) {

      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
    }
    Map<String, dynamic> headersPassed = headers;
    d.FormData? formData = formDatas;
    String serviceUrlPassed = serviceUrl;
    String methodPassed = method;
    Map<String, dynamic> paramsPassed = params ?? {};

    if (await checkInternet()) {
      final timer = Stopwatch();
      timer.start();
      if (showProcess == true) {
        showLoadingDialog();
      }
      try {
        d.Response response;
        if (methodPassed == getMethod) {
          response = await dio.get("${APIEndPoints.endPoint}$serviceUrlPassed",
              queryParameters: paramsPassed,
              options: d.Options(
                headers: headersPassed,
              ));
        } else if (methodPassed == postMethod) {
          response = await dio.post("${APIEndPoints.endPoint}$serviceUrlPassed",
              queryParameters: paramsPassed,
              data: body ?? formData,
              options: d.Options(
                headers: headersPassed,
              ));
          kDebugPrint("Response >>  $response");
        } else if (methodPassed == putMethod) {
          response = await dio.put("${APIEndPoints.endPoint}$serviceUrlPassed",
              queryParameters: paramsPassed,
              data: body ?? formData,
              options: d.Options(headers: headersPassed));
        } else {
          response = await dio.delete(
              "${APIEndPoints.endPoint}$serviceUrlPassed",
              queryParameters: paramsPassed,
              data: body ?? formData,
              options: d.Options(headers: headersPassed));
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          timer.reset();
          if (showProcess == true) {
            hideLoadingDialog();
          }
          success(response);
        } else {
          if (showProcess == true) {
            hideLoadingDialog();
          }

          error(response);
        }
      } on d.DioException catch (dioError) {
        if (showProcess == true) {
          hideLoadingDialog();
        }
        error(dioError.response);
        if (dioError.type == d.DioExceptionType.sendTimeout ||
            dioError.type == d.DioExceptionType.connectionTimeout) {
          apiAlertDialog(
            message: connectionTimeOutMessage,
          );
        }
      } catch (e) {
        if (showProcess == true) {
          hideLoadingDialog();
        }
        // apiAlertDialog(
        //   message: e.toString(),
        // );
      }

      if (showProcess == true) {
        hideLoadingDialog();
      }
    } else {
      apiAlertDialog(
          message: interNetMessage,
          buttonTitle: "try again",
          buttonCallBack: () {
            callAPI(
                params: paramsPassed,
                serviceUrl: "${APIEndPoints.endPoint}$serviceUrl",
                method: methodPassed,
                success: success,
                error: error,
                showProcess: showProcess);
          });
    }
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  apiAlertDialog({
    required String message,
    String? buttonTitle,
    Function? buttonCallBack,
  }) {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    if (!Get.isDialogOpen!) {
      Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: CupertinoAlertDialog(
              title: const Text(StorageKey.appName),
              // content: Text(message),
              content: Column(
                children: [
                  (message != interNetMessage)
                      ? const SizedBox()
                      : Lottie.asset(ImagePath.noInternet, height: 200),
                  Text(message),
                  const SizedBox(height: 10),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(buttonTitle ?? "Try again"),
                  onPressed: () {
                    if (buttonCallBack != null) {
                      buttonCallBack();
                    }
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("Go Back"),
                  onPressed: () {
                    Get.back();
                    // getX.Get.back();
                  },
                )
              ]),
        ),
        barrierDismissible: false,
        transitionCurve: Curves.easeInCubic,
        transitionDuration: const Duration(milliseconds: 400),
      );
    }
  }
}
