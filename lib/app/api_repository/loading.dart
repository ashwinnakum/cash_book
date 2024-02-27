import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data/all.dart';

class Loading {
  AppColors appColors = AppColors();

  Loading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..contentPadding = const EdgeInsets.all(18)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..lineWidth = 2
      ..radius = 15
      ..progressColor = AppColors.primary
      ..backgroundColor = AppColors.primary
      ..indicatorColor = AppColors.whiteColor
      ..textColor = AppColors.whiteColor
      ..maskColor = AppColors.blackColor.withOpacity(0.4)
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show();
  }

  static void toast(String text) {
    EasyLoading.showToast(text);
  }

  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }
}
