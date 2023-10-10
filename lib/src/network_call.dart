part of dio_handler;

/// `DioHandler` is a class designed to simplify network API calls in Flutter applications using the Dio HTTP client.
///
/// It provides various utility functions and customization options to streamline the process of making API requests.

class DioHandler {
  final Dio dio;
  final Widget? customErrorDialog; // Custom error dialog widget (optional)
  final Widget? customLoadingDialog; // Custom loading dialog widget (optional)
  final bool isCheckNetworkConnectivity; // Enable network connectivity check
  final bool isAlertDialogs; // Show alert dialogs for errors
  final bool isCallBackTime; // Measure API callback time

  /// Creates an instance of `DioHandler` with the provided configuration.
  ///
  /// - [dio]: An instance of Dio for making HTTP requests.
  /// - [customErrorDialog]: An optional custom error dialog widget to display error messages.
  /// - [customLoadingDialog]: An optional custom loading dialog widget to show during API calls.
  /// - [isCheckNetworkConnectivity]: Set to `true` to enable network connectivity checks before making requests.
  /// - [isAlertDialogs]: Set to `true` to display alert dialogs for API errors.
  /// - [isCallBackTime]: Set to `true` to measure and print the time taken for API callbacks (debug mode).
  DioHandler({
    required this.dio,
    this.customErrorDialog,
    this.customLoadingDialog,
    this.isCheckNetworkConnectivity = false,
    this.isAlertDialogs = true,
    this.isCallBackTime = false,
  });

  /// Makes an HTTP API request using Dio and handles the response and errors.
  ///
  /// - [params]: Query parameters for the request (GET request).
  /// - [headers]: Headers for the request.
  /// - [body]: Request body data for POST or PUT requests.
  /// - [serviceUrl]: The URL of the API endpoint.
  /// - [method]: The HTTP request method (GET, POST, PUT, DELETE).
  /// - [formData]: Optional FormData for multipart requests (e.g., file uploads).
  /// - [success]: A callback function to handle a successful API response.
  /// - [error]: A callback function to handle API errors.
  /// - [showProcess]: Set to `true` to display a loading dialog during the API call.
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
        apiAlertDialog(message: 'No internet connection', customErrorDialog: customErrorDialog);
      }
      return;
    }

    try {
      Response response;
      final options = Options(headers: headers);

      if (showProcess) {
        // Show loading dialog when 'showProcess' is true
        showLoadingDialog(customLoadingDialog: customLoadingDialog);
      }

      final stopwatch = Stopwatch()..start(); // Start a timer if 'isCallBackTime' is true

      // Make the appropriate HTTP request based on the 'method'
      switch (method) {
        case 'GET':
          response = await dio.get(serviceUrl, queryParameters: params, options: options);
          break;
        case 'POST':
          response = await dio.post(serviceUrl, data: body ?? formData, options: options);
          break;
        case 'PUT':
          response = await dio.put(serviceUrl, data: body ?? formData, options: options);
          break;
        case 'DELETE':
          response = await dio.delete(serviceUrl, data: body ?? formData, options: options);
          break;
        default:
          throw ArgumentError('Invalid method: $method');
      }

      if (isCallBackTime) {
        // Stop the timer and print the API request time if 'isCallBackTime' is true
        stopwatch.stop();
        kDebugPrint('API request took ${stopwatch.elapsedMilliseconds} milliseconds');
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
        apiAlertDialog(message: 'An error occurred: $e', customErrorDialog: customErrorDialog);
      }
      error(e);
    } finally {
      if (showProcess) {
        // Hide the loading dialog when 'showProcess' is true
        hideLoadingDialog();
      }
    }
  }
}

// A global key to access the current navigation context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();