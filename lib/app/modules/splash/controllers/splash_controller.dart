import 'package:cash_book/app/data/all.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (GetStorageData().containKey(GetStorageData().userId)) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
    super.onInit();
  }
}
