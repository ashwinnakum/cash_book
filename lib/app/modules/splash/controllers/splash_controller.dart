import 'package:cash_book/app/data/all.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAllNamed(Routes.HOME);
    });
    super.onInit();
  }
}
