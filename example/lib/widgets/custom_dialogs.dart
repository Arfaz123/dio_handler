import 'package:flutter/material.dart';

customAlertDialog({required String alertText, required BuildContext context}) {
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
}

customLoadingDialog(
    {required String loadingText, required BuildContext context}) {
  return Center(
    child: Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.white,
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircularProgressIndicator(),
            Text(loadingText),
          ],
        ),
      ),
    ),
  );
}
