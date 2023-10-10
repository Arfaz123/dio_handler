part of dio_handler;

/// The `showLoadingDialog` function displays a loading dialog during API requests.
///
/// It provides an optional `customLoadingDialog` parameter, allowing you to use
/// a custom loading dialog widget if provided. If no custom dialog is provided,
/// it displays a default loading dialog with a circular progress indicator.
///
/// Usage Example:
/// ```dart
/// showLoadingDialog();
/// // API request is in progress, and the loading dialog is displayed
/// ```
void showLoadingDialog({final Widget? customLoadingDialog}) {
  Future.delayed(const Duration(milliseconds: 0), () {
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          if (customLoadingDialog != null) {
            // Use the custom loading dialog widget if provided
            return customLoadingDialog;
          } else {
            return Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  });
}

/// The `apiAlertDialog` function displays an alert dialog for API errors.
///
/// It allows you to provide a custom error dialog widget through the
/// `customErrorDialog` parameter. If no custom dialog is provided, it displays
/// a default alert dialog with the error message.
///
/// Usage Example:
/// ```dart
/// apiAlertDialog(message: 'An error occurred');
/// // Displays an alert dialog with the error message
/// ```
void apiAlertDialog({
  required String message,
  final Widget? customErrorDialog,
}) {
  showDialog(
    barrierDismissible: false,
    context: navigatorKey.currentContext!,
    builder: (context) {
      if (customErrorDialog != null) {
        // Use the custom error dialog widget if provided
        return customErrorDialog;
      } else {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      }
    },
  );
}

/// The `hideLoadingDialog` function hides the loading dialog.
///
/// It closes the loading dialog that was previously displayed using
/// the `showLoadingDialog` function.
///
/// Usage Example:
/// ```dart
/// hideLoadingDialog();
/// // Hides the loading dialog if it is currently displayed
/// ```
void hideLoadingDialog() {
  Navigator.of(navigatorKey.currentContext!).pop();
}

/// The `kDebugPrint` function prints debugging information if running in debug mode.
///
/// It checks if the application is running in debug mode using the `kDebugMode`
/// variable provided by the `flutter/foundation.dart` package. If in debug mode,
/// it prints the provided data.
///
/// Usage Example:
/// ```dart
/// kDebugPrint('Debug information');
/// // Prints 'Debug information' to the console in debug mode
/// ```
void kDebugPrint(data) {
  if (kDebugMode) {
    print(data);
  }
}
