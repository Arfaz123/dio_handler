part of dio_handler;

class DioHandler {
  final Dio dio;
  final Widget? customErrorDialog;
  final Widget? customLoadingDialog;
  final bool isCheckNetworkConnectivity;
  final bool isAlertDialogs;
  final bool isCallBackTime;
  final BuildContext Function() getBuildContext; // Callback to get BuildContext

  DioHandler({
    required this.dio,
    this.customErrorDialog,
    this.customLoadingDialog,
    required this.getBuildContext, // Pass a callback to get BuildContext
    this.isCheckNetworkConnectivity = false,
    this.isAlertDialogs = true,
    this.isCallBackTime = false,
  });

  Future<void> callAPI({
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    required String serviceUrl,
    required String method,
    FormData? formData,
    required Function(Response) success,
    required Function(dynamic) error,
    required bool showProcess,
  }) async {
    // Check network connectivity if enabled
    if (isCheckNetworkConnectivity && !(await isInternetAvailable())) {
      if (isAlertDialogs) {
        // Display an error dialog for no internet connection
        apiAlertDialog(
          message: 'No internet connection',
          customErrorDialog: customErrorDialog,
          buildContext: getBuildContext(), // Get BuildContext via callback
        );
      }
      return;
    }

    try {
      Response response;
      final options = Options(headers: headers);

      if (showProcess) {
        // Show loading dialog when 'showProcess' is true
        showLoadingDialog(
          customLoadingDialog: customLoadingDialog,
          buildContext: getBuildContext(), // Get BuildContext via callback
        );
      }

      final stopwatch = Stopwatch()
        ..start(); // Start a timer if 'isCallBackTime' is true

      // Make the appropriate HTTP request based on the 'method'
      switch (method) {
        case 'GET':
          response = await dio.get(serviceUrl,
              queryParameters: params, options: options);
          break;
        case 'POST':
          response = await dio.post(serviceUrl,
              data: body ?? formData, options: options);
          break;
        case 'PUT':
          response = await dio.put(serviceUrl,
              data: body ?? formData, options: options);
          break;
        case 'DELETE':
          response = await dio.delete(serviceUrl,
              data: body ?? formData, options: options);
          break;
        default:
          throw ArgumentError('Invalid method: $method');
      }

      if (isCallBackTime) {
        // Stop the timer and print the API request time if 'isCallBackTime' is true
        stopwatch.stop();
        kDebugPrint(
            'API request took ${stopwatch.elapsedMilliseconds} milliseconds');
      }

      if (response.statusCode! >= 400) {
        // Handle errors, including HTTP status codes 400 and above
        error(response);
      } else {
        // Pass other responses as-is
        success(response);
      }
    } catch (e) {
      if (isAlertDialogs) {
        // Display an error dialog for exceptions
        apiAlertDialog(
          message: 'An error occurred: $e',
          customErrorDialog: customErrorDialog,
          buildContext: getBuildContext(), // Get BuildContext via callback
        );
      }
      error(e);
      // Hide the loading dialog when 'showProcess' is true
      hideLoadingDialog(
          buildContext: getBuildContext()); // Get BuildContext via callback
    } finally {
      if (showProcess) {
        // Hide the loading dialog when 'showProcess' is true
        hideLoadingDialog(
            buildContext: getBuildContext()); // Get BuildContext via callback
      }
    }
  }
}
