import 'package:cash_book/app/data/all.dart';

class LoginController extends GetxController {
  TextEditingController phoneNo = TextEditingController(/*text: '9825045935'*/);
  TextEditingController password = TextEditingController(/*text: '123@admin'*/);

  validation() {
    if (Utils().isValidationEmpty(phoneNo.text.trim())) {
      Utils().showToast(message: Strings.phoneErrorMessage, context: Get.context!);
    } else if (Utils().isValidationEmpty(password.text.trim())) {
      Utils().showToast(message: Strings.passwordErrorMessage, context: Get.context!);
    } else {
      loginApi();
    }
  }

  loginApi() async {
    FormData formData = FormData.fromMap({
      'phone_number': phoneNo.text.trim(),
      'password': Utils().generateMd5(password.text.trim()),
    });
    var data = await APIFunction().apiCall(apiName: Constants.login, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      await GetStorageData().saveString(GetStorageData().userId, data['data']['user_id']);
      await GetStorageData().saveString(GetStorageData().name, data['data']['name']);
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
      Get.offAllNamed(Routes.HOME, arguments: data['data']['name']);
    } else {
      Utils().showToast(context: Get.context!, message: data['ResponseMsg']);
    }
  }
}
