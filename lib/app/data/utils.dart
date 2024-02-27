import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'all.dart';

extension FicListExtension<T> on List<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) map) sync* {
    for (var index = 0; index < length; index++) {
      yield map(index, this[index]);
    }
  }
}

/// <<< To get common function --------- >>>
class Utils {
  mainStatusBar() {
    if (Platform.isAndroid) {
      return SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.whiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.whiteColor,
      ));
    } else {
      return SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColors.whiteColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.whiteColor,
          systemNavigationBarDividerColor: AppColors.whiteColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  appStatusBar() {
    if (Platform.isAndroid) {
      return SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.whiteColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: AppColors.whiteColor,
        ),
      );
    } else {
      return SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColors.whiteColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.whiteColor,
          systemNavigationBarDividerColor: AppColors.whiteColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  /// <<< To show snackBar massage  --------- >>>
  void showSnackBar({required BuildContext context, required String message, bool? isOk = false}) {
    Future<void>.delayed(Duration.zero, () {
      Get.snackbar(
        "",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: isOk! ? Colors.green.shade600 : Colors.red.shade600,
        colorText: AppColors.whiteColor,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        padding: const EdgeInsets.only(bottom: 15, top: 10, left: 15, right: 15),
        titleText: Container(),
      );
    });
  }

  /// <<< To create dark status bar --------- >>>
  static void darkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparentColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.whiteColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppColors.whiteColor,
    ));
  }

  /// <<< To create light status bar --------- >>>
  static void lightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.whiteColor,
        systemNavigationBarDividerColor: AppColors.whiteColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// <<< To choose screens portrait --------- >>>
  static void screenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// <<< To check data, string, list, object are empty or not --------- >>>
  bool isValidationEmpty(String? val) {
    if (val == null || val.isEmpty || val == "null" || val == "" || val == "NULL") {
      return true;
    } else {
      return false;
    }
  }

  /// <<< To check email valid or not --------- >>>
  bool emailValidator(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }

  /// <<< To check password valid or not --------- >>>
  bool passwordValidator(String contact) {
    String p = r'^{8}$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To transfer string to Md5 --------- >>>
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  String calculateMD5(String input) {
    List<int> bytes = utf8.encode(input);
    print('ashahshshahsas---${String.fromCharCodes(bytes)}');

    Digest md5Hash = md5.convert(bytes);
    String result = md5Hash.toString();
    return result;
  }

  /// <<< hide keyboard --------- >>>
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static SnackBar snackBar({required String text, Color? backgroundColor, Color? textColor}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      elevation: 0.0,
      duration: const Duration(seconds: 1),
      content: AppText(
        text,
        color: AppColors.whiteColor,
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor ?? AppColors.primary,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    return snackBar;
  }
}

/// <<< Error Massage Red color --------- >>>
void printError(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[31m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Ok Status Massage Green Color --------- >>>
void printOkStatus(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[32m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Warning Massage Yellow Color --------- >>>
void printWarning(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[33m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Action Massage Blue Color --------- >>>
void printAction(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[34m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Cancel Massage Gray Color --------- >>>
void printCancel(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[36m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
