import 'package:cash_book/app/data/all.dart';

class HomeController extends GetxController {
  TextEditingController search = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxDouble scrollOffSet = 0.0.obs;
  RxBool isScroll = false.obs;

  Widget childPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text(
              "Edit",
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Delete",
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        elevation: 5,
        color: AppColors.whiteColor,
        child: const Icon(Icons.more_vert_outlined, color: AppColors.greyText),
      );

  @override
  void onInit() {
    /*Timer(const Duration(seconds: 1), () {
      printAction('isScrollValue----------------->>>>>>${isScroll.value}');
      update();
    });*/
    scrollController.addListener(() {
      if (scrollOffSet.value <= scrollController.offset) {
        isScroll.value = false;
      } else {
        isScroll.value = true;
      }
      scrollOffSet.value = scrollController.offset;
    });
    super.onInit();
  }
}
