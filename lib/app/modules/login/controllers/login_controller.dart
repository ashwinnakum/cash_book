import 'package:cash_book/app/data/all.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController(text: 'admin@cachbook.com');
  TextEditingController password = TextEditingController(text: '123@admin');

  validation() {
    if (Utils().isValidationEmpty(email.text.trim())) {
      Utils().showToast(message: Strings.emailErrorMessage, context: Get.context!);
    } else if (Utils().isValidationEmpty(password.text.trim())) {
      Utils().showToast(message: Strings.passwordErrorMessage, context: Get.context!);
    } else {
      loginApi();
    }
  }

  loginApi() async {
    FormData formData = FormData.fromMap({
      'email': email.text.trim(),
      'password': password.text.trim(),
    });
    var data = await APIFunction().apiCall(apiName: Constants.login, context: Get.context!, params: formData);
    if (data['ResponseCode'] == 1) {
      await GetStorageData().saveString(GetStorageData().loginModel, GetStorageData().loginModel);
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
      Get.offAllNamed(Routes.HOME);
    } else {
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
    }
  }
}
