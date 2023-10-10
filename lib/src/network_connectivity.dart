part of dio_handler;

/// The `isInternetAvailable` function checks if there is an active internet connection.
///
/// It uses the `Connectivity` package to determine the network connectivity status.
/// Returns `true` for mobile data or Wi-Fi connectivity, and `false` otherwise.
///
/// Usage Example:
/// ```dart
/// if (await isInternetAvailable()) {
///   // There is an active internet connection
///   // You can proceed with network operations
/// } else {
///   // No internet connection is available
///   // Handle offline mode gracefully
/// }
/// ```
Future<bool> isInternetAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}
