
Future? apiDialog(String msg) {
  return Get.dialog(
    barrierDismissible: false,
    CupertinoAlertDialog(
      title: Text(msg, style: Get.theme.primaryTextTheme.headline1),
      actions: [
        CupertinoActionSheetAction(
          child: Text('btn_ok'.tr, style: Get.theme.primaryTextTheme.headline1),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ),
  );
}