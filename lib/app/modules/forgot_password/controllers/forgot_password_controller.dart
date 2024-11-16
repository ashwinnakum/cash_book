import '../../../data/all.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController mobileNumber = TextEditingController();

  validation() {
    if (Utils().isValidationEmpty(mobileNumber.text.trim())) {
      Utils().showToast(message: 'Please enter phone number', context: Get.context!);
    } else if (!Utils().phoneValidator(mobileNumber.text.trim())) {
      Utils().showToast(message: 'Please enter valid phone number', context: Get.context!);
    } else {
      forGotPasswordApi();
    }
  }

  forGotPasswordApi() async {
    FormData formData = FormData.fromMap({
      'phone_number': mobileNumber.text.trim(),
    });
    var data = await APIFunction().apiCall(apiName: Constants.forgotPassword, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      Get.toNamed(Routes.OTP, arguments: {'mobileNo': mobileNumber.text, 'otp': data['data']['otp']});
      Utils().showToast(context: Get.context!, message: 'OTP sent successfully');
    } else {
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
    }
  }
}
