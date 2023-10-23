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
dynamic showLoadingDialog(
    {final dynamic? customLoadingDialog, required buildContext}) {
  if (customLoadingDialog != null) {
    // Use the custom loading dialog widget if provided
    return customLoadingDialog;
  } else {
    return Future.delayed(const Duration(milliseconds: 0), () {
      showDialog(
          barrierDismissible: false,
          context: buildContext,
          builder: (context) {
            return Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(8),
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          });
    });
  }
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
dynamic apiAlertDialog({
  required String message,
  required buildContext,
  final dynamic? customErrorDialog,
}) {
  if (customErrorDialog != null) {
    return customErrorDialog;
  } else {
    return showDialog(
        barrierDismissible: false,
        context: buildContext,
        builder: (context) {
          return AlertDialog(
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
        });
  }
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
void hideLoadingDialog({required buildContext}) {
  Navigator.of(buildContext).pop();
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
