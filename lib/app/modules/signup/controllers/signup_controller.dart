import '../../../data/all.dart';

class SignupController extends GetxController {
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  validation() {
    if (Utils().isValidationEmpty(phoneNo.text.trim())) {
      Utils().showToast(message: 'Please enter phone number', context: Get.context!);
    } else if (!Utils().phoneValidator(phoneNo.text.trim()) || phoneNo.text.trim().length != 10) {
      Utils().showToast(message: 'Please enter valid phone number', context: Get.context!);
    } else if (Utils().isValidationEmpty(password.text.trim())) {
      Utils().showToast(message: 'Please enter password', context: Get.context!);
    } else if (Utils().isValidationEmpty(confirmPassword.text.trim())) {
      Utils().showToast(message: 'Please enter confirm password', context: Get.context!);
    } else if (password.text.trim() != confirmPassword.text.trim()) {
      Utils().showToast(message: 'Password and confirm password does not match', context: Get.context!);
    } else {
      signUpApi();
    }
  }

  signUpApi() async {
    FormData formData = FormData.fromMap({
      'phone_number': phoneNo.text.trim(),
      'password': Utils().generateMd5(password.text.trim()),
    });
    var data = await APIFunction().apiCall(apiName: Constants.signUp, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      Get.offAllNamed(Routes.LOGIN);
      Utils().showSnackBar(context: Get.context!, message: data['ResponseMsg'], isOk: true);
    } else {
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
    }
  }
}
