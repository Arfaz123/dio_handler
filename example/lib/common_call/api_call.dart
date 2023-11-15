import 'package:dio_handler/dio_handler.dart';
import 'package:example/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';

void makeGetApiRequest(BuildContext context) {
  final dioHandler = DioHandler(
    getBuildContext: context,
    isCheckNetworkConnectivity: true,
    isAlertDialogs: false,
    customLoadingDialog:
        customLoadingDialog(loadingText: "Loading...", context: context),
  );

  dioHandler.callAPI(
    serviceUrl: 'https://jsonplaceholder.typicode.com/posts/1',
    method: 'GET',
    showProcess: true, // Show a loading dialog
    success: (response) {
      // Handle a successful response here
      kDebugPrint('Response: ${response.data}');
    },
    error: (error) {
      // Handle errors or exceptions here
      kDebugPrint('Error: $error');
    },
  );
}

void makePostApiRequest(BuildContext context) {
  final dioHandler = DioHandler(
      getBuildContext: context,
      isCheckNetworkConnectivity: true,
      isAlertDialogs: false,
      customErrorDialog: customAlertDialog(
          alertText: "This Is A Customer Alert Dialog.", context: context));

  // Example POST request data
  final Map<String, dynamic> postData = {
    'userId': 1,
    'id': 1,
    'title': 'New Post',
    'body': 'This is a new post.',
  };

  dioHandler.callAPI(
    serviceUrl: 'https://jsonplaceholder.typicode.com/posts',
    method: 'POST',
    body: postData,
    success: (response) {
      // Handle a successful response here
      kDebugPrint('Response: ${response.data}');
    },
    error: (error) {
      // Handle errors or exceptions here
      kDebugPrint('Error: $error');
    },
    showProcess: false, // Show a loading dialog
  );
}