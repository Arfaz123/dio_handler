part of dio_handler;

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
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        });
  });
}

void hideLoadingDialog(BuildContext context) {
  Navigator.pop(context);
}

