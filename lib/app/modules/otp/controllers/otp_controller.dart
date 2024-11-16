import '../../../data/all.dart';

class OtpController extends GetxController {
  TextEditingController pinPutController = TextEditingController();
  String? mobileNumber;
  String? otp;

  @override
  void onInit() {
    if (Get.arguments != null) {
      mobileNumber = Get.arguments['mobileNo'];
      otp = Get.arguments['otp'].toString();
    }
    super.onInit();
  }

  validation() async {
    if (Utils().isValidationEmpty(pinPutController.text.trim())) {
      Utils().showToast(message: 'Please enter 6 digit otp', context: Get.context!);
    } else if (otp != pinPutController.text.trim()) {
      Loading.show();
      await Future.delayed(Duration(milliseconds: 300));
      Loading.dismiss();
      Utils().showToast(message: 'Please enter valid otp', context: Get.context!);
    } else {
      Loading.show();
      await Future.delayed(Duration(milliseconds: 300));
      Loading.dismiss();
      Get.toNamed(Routes.NEW_PASSWORD, arguments: {
        'mobileNumber': mobileNumber,
        'otp': otp,
      });
    }
  }

  resendOtpApi() async {
    FormData formData = FormData.fromMap({
      'phone_number': mobileNumber,
    });
    var data = await APIFunction().apiCall(apiName: Constants.forgotPassword, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      pinPutController.clear();
      otp = data['data']['otp'].toString();
      update();
    } else {
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
    }
  }
}
