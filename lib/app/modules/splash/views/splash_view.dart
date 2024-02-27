import 'dart:io';

import '../../../data/all.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.primary,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.primary,
      ));
    } else {
      Utils.lightStatusBar();
    }
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          top: false,
          child: Container(
            color: AppColors.primary,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
