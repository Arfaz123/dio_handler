import 'package:flutter/material.dart';
import 'common_call/api_call.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Create a Dio instance

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
}
