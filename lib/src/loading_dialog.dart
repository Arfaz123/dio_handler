import 'package:dio_handler/src/image_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showLoadingDialog(BuildContext context) {
  Future.delayed(const Duration(milliseconds: 0), () {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 100,
                width: 100,
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: Lottie.asset(ImagePath.loadingLottie,
                        height: 70, width: 70)),
              ),
            ),
          );
        });
  });
}

void hideLoadingDialog(BuildContext context) {
  Navigator.pop(context);
}

