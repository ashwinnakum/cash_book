import '../../../data/all.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? mobileNumber;
  String? otp;

  @override
  void onInit() {
    if (Get.arguments != null) {
      mobileNumber = Get.arguments['mobileNumber'];
      otp = Get.arguments['otp'].toString();
    }
    super.onInit();
  }

  validation() {
    if (Utils().isValidationEmpty(newPasswordController.text.trim())) {
      Utils().showToast(message: 'Please enter new password', context: Get.context!);
    } else if (Utils().isValidationEmpty(confirmPasswordController.text.trim())) {
      Utils().showToast(message: 'Please enter confirm new password', context: Get.context!);
    } else if (newPasswordController.text.trim() != confirmPasswordController.text.trim()) {
      Utils().showToast(message: 'New password and confirm new password does not match', context: Get.context!);
    } else {
      updatePasswordApi();
    }
  }

  updatePasswordApi() async {
    FormData formData = FormData.fromMap({
      'phone_number': mobileNumber,
      'otp': otp,
      'new_password': Utils().generateMd5(newPasswordController.text.trim()),
    });
    var data = await APIFunction().apiCall(apiName: Constants.updatePassword, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      Get.offAndToNamed(Routes.LOGIN);
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
    } else {
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
    }
  }
}
