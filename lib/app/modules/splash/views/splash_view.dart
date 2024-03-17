import 'dart:io';

import 'package:lottie/lottie.dart';

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
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.whiteColor,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.transparentColor,
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
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 50.w, bottom: 50.h),
                  child: Lottie.asset(ImagePath.imagesIcSplash),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 200.h),
                  child: AppText(
                    'Cash Book'.toUpperCase(),
                    fontSize: 32.sp,
                    letterSpacing: 1.1,
                    fontFamily: FontFamily.bold,
                    color: AppColors.primary,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
