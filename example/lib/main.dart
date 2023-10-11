import 'package:dio/dio.dart'; // Import Dio package
import 'package:dio_handler/dio_handler.dart';
import 'package:flutter/foundation.dart'; // Import DioHandler package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Dio dio = Dio(); // Initialize Dio instance

  final DioHandler dioHandler = DioHandler(
    dio: Dio(), // Pass the Dio instance to DioHandler
    customErrorDialog:
        const MyCustomErrorDialog(), // Optional: Provide a custom error dialog widget
    customLoadingDialog:
        const MyCustomLoadingDialog(), // Optional: Provide a custom loading dialog widget
    isCheckNetworkConnectivity:
        true, // Optional: Enable network connectivity check
    isAlertDialogs: true, // Optional: Show alert dialogs for errors
    isCallBackTime: true, // Optional: Measure API callback time
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DioHandler Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Example GET request
                  dioHandler.callAPI(
                    serviceUrl: 'https://jsonplaceholder.typicode.com/posts/1',
                    method: 'GET',
                    success: (response) {
                      // Handle successful response here
                      kDebugPrint('GET Request Successful');
                      kDebugPrint(response.data);
                    },
                    error: (error) {
                      // Handle error response here
                      kDebugPrint('GET Request Error');
                      kDebugPrint(error);
                    },
                    showProcess: true,
                  );
                },
                child: const Text('Make GET Request'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Example POST request
                  dioHandler.callAPI(
                    serviceUrl: 'https://jsonplaceholder.typicode.com/posts',
                    method: 'POST',
                    body: {'title': 'New Post', 'body': 'This is a new post'},
                    success: (response) {
                      // Handle successful response here
                      kDebugPrint('POST Request Successful');
                      kDebugPrint(response.data);
                    },
                    error: (error) {
                      // Handle error response here
                      kDebugPrint('POST Request Error');
                      kDebugPrint(error);
                    },
                    showProcess: true,
                  );
                },
                child: const Text('Make POST Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom error dialog widget (replace with your own implementation)
class MyCustomErrorDialog extends StatelessWidget {
  const MyCustomErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Custom Error Dialog'),
      content: const Text('An error occurred.'),
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
}

// Custom loading dialog widget (replace with your own implementation)
class MyCustomLoadingDialog extends StatelessWidget {
  const MyCustomLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

// Prints 'Debug information' to the console in debug mode
void kDebugPrint(data) {
  if (kDebugMode) {
    print(data);
  }
}
