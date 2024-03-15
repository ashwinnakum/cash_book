import 'package:cash_book/app/data/all.dart';

class AddDetailController extends GetxController {
  TextEditingController addAmount = TextEditingController();
  String withScreen = Strings.cashIn;
  @override
  void onInit() {
    if (Get.arguments != null) {
      withScreen = Get.arguments;
    }
    super.onInit();
  }
}
