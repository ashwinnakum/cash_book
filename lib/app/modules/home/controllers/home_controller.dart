import 'package:cash_book/app/commonWidget/common_bottom_sheet.dart';
import 'package:cash_book/app/data/all.dart';

class HomeController extends GetxController {
  TextEditingController search = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxDouble scrollOffSet = 0.0.obs;
  RxBool isScroll = false.obs;
  TextEditingController addBookController = TextEditingController();
  FocusNode searchNode = FocusNode();

  List<CommonModel> suggestionList = [
    CommonModel(name: '${Utils().changeDateFormat(date: DateTime.now(), outputFormat: 'MMMM')} Expenses'),
    CommonModel(name: Strings.salaryBook),
    CommonModel(name: Strings.projectBook),
    CommonModel(name: Strings.clientRecord),
  ];

  @override
  void onInit() {
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

  addBookSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CommonBottomSheet(
              widget: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.close, size: 26.h)),
                          25.horizontalSpace,
                          AppText(
                            Strings.addNewBook,
                            fontSize: 18.sp,
                            color: AppColors.blackColor,
                            fontFamily: FontFamily.semiBold,
                          )
                        ],
                      ),
                    ),
                    15.verticalSpace,
                    Container(height: 1.h, color: AppColors.greyText.withOpacity(0.2), width: double.infinity),
                    30.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 55.h,
                            child: TextField(
                              controller: addBookController,
                              focusNode: searchNode,
                              cursorColor: AppColors.primary,
                              style: AppTextStyle(textFamily: FontFamily.medium, textSize: 16.sp, textColor: AppColors.blackColor),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.primary, width: 1.3),
                                ),
                                labelStyle: AppTextStyle(
                                    textFamily: FontFamily.medium,
                                    textSize: 16.sp,
                                    textColor: addBookController.text.trim().isNotEmpty ? AppColors.primary : AppColors.greyText),
                                labelText: Strings.enterBookName,
                                hintText: Strings.enterBookName,
                              ),
                              onChanged: (text) {},
                            ),
                          ),
                          30.verticalSpace,
                          AppText(
                            Strings.suggestion,
                            fontSize: 13.sp,
                            fontFamily: FontFamily.semiBold,
                            color: AppColors.greyText,
                          ),
                          20.verticalSpace,
                          Wrap(
                            children: List.generate(suggestionList.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  addBookController.text = suggestionList[index].name!;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(9.h),
                                  margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.035),
                                      border: Border.all(color: AppColors.primary, width: 1.3),
                                      borderRadius: BorderRadius.all(Radius.circular(30.r))),
                                  child: AppText(suggestionList[index].name!, color: AppColors.primary, fontSize: 13.sp),
                                ),
                              );
                            }),
                          ),
                          40.verticalSpace,
                          GestureDetector(
                            onTap: () {
                              if (addBookController.text.trim().isNotEmpty) {}
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: addBookController.text.trim().isNotEmpty ? AppColors.primary : AppColors.greyText.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: addBookController.text.trim().isNotEmpty ? AppColors.whiteColor : AppColors.greyText.withOpacity(0.9),
                                    ),
                                    10.horizontalSpace,
                                    AppText(
                                      Strings.addNewBook,
                                      fontFamily: FontFamily.semiBold,
                                      fontSize: FontSize.s16,
                                      color: addBookController.text.trim().isNotEmpty ? AppColors.whiteColor : AppColors.greyText.withOpacity(0.9),
                                    ),
                                  ],
                                )),
                          ),
                          (MediaQuery.of(context).padding.bottom).verticalSpace
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    await Future.delayed(Duration(milliseconds: 100));
    FocusScope.of(Get.context!).requestFocus(searchNode);
  }

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
}
