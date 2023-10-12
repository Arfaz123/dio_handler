import 'package:dio/dio.dart';
import 'package:dio_handler/dio_handler.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  final Dio dio = Dio();

  MyApp({super.key}); // Create a Dio instance

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DioHandler Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  makeGetApiRequest(context);
                },
                child: const Text('Make Get API Request'),
              ),
              Container(
                color: Colors.lightBlueAccent,
                alignment: Alignment.center,
                height: size.height / 7,
                width: size.width / 2,
                child: const Text(
                  "Sample Data for post API:{'userId': 1,'id': 1,'title': 'New Post','body': 'This is a new post.',}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  makePostApiRequest(context);
                },
                child: const Text('Make Post API Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void makeGetApiRequest(context) {
    final dioHandler = DioHandler(
        dio: dio,
        getBuildContext: () => context,
        isCheckNetworkConnectivity: true);

    dioHandler.callAPI(
      serviceUrl: 'https://jsonplaceholder.typicode.com/posts/0',
      method: 'GET',
      success: (response) {
        // Handle a successful response here
        kDebugPrint('Response: ${response.data}');
      },
      error: (error) {
        // Handle errors or exceptions here
        kDebugPrint('Error: $error');
      },
      showProcess: true, // Show a loading dialog
    );
  }

  void makePostApiRequest(context) {
    final dioHandler = DioHandler(
        dio: dio,
        getBuildContext: () => context,
        isCheckNetworkConnectivity: true,
        isAlertDialogs: true,
        customErrorDialog: customAlertDialog(
            alertText: "There is Some Error occurred.", context: context));

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
      showProcess: true, // Show a loading dialog
    );
  }

  customAlertDialog({required String alertText, context}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 150,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(alertText),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

void kDebugPrint(data) {
  if (kDebugMode) {
    print(data);
  }
}
