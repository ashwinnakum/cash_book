import 'package:cash_book/app/commonWidget/common_bottom_sheet.dart';
import 'package:cash_book/app/commonWidget/dialog.dart';
import 'package:cash_book/app/data/all.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/home_model.dart';

class HomeController extends GetxController {
  TextEditingController search = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxDouble scrollOffSet = 0.0.obs;
  RxBool isScroll = false.obs;
  TextEditingController addBookNameController = TextEditingController();
  FocusNode searchNode = FocusNode();
  HomeData? homeData;
  List<BookHistories> bookHistories = [];
  List<BookHistories> finalBookHistories = [];
  RxString noDataFound = ''.obs;

  List<CommonModel> suggestionList = [
    CommonModel(name: '${Utils().changeDateFormat(date: DateTime.now(), outputFormat: 'MMMM')} Expenses'),
    CommonModel(name: Strings.salaryBook),
    CommonModel(name: Strings.projectBook),
    CommonModel(name: Strings.clientRecord),
  ];

  List selectDateFilter = [
    "Today",
    "Last Month",
    "Last Year",
    "Custom",
  ];

  RxInt isSelected = (-1).obs;
  RxInt finalSelected = (-1).obs;

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  RxBool isCustom = false.obs;

  @override
  void onInit() {
    homeApi();
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

  homeApi({bool isLoading = true, bool textFieldClear = false}) async {
    String startDate = '';
    String endDate = '';
    if (finalSelected.value != -1) {
      if (finalSelected.value != 3) {
        endDate = Utils().changeDateFormat(date: DateTime.now(), outputFormat: 'yyyy-MM-dd');
        startDate = Utils().changeDateFormat(
            date: finalSelected.value == 0
                ? DateTime.now()
                : finalSelected.value == 1
                    ? Jiffy.now().subtract(months: 1).dateTime
                    : Jiffy.now().subtract(years: 1).dateTime,
            outputFormat: 'yyyy-MM-dd');
      } else if (finalSelected.value == 3) {
        endDate = Utils().changeDateFormat(date: selectedStartDate, outputFormat: 'yyyy-MM-dd');
        startDate = Utils().changeDateFormat(date: selectedEndDate, outputFormat: 'yyyy-MM-dd');
      }
    }
    FormData formData = FormData.fromMap(
      ({
        if (finalSelected.value != -1 && startDate.isNotEmpty) 'start_date': startDate,
        if (finalSelected.value != -1 && endDate.isNotEmpty) 'end_date': endDate,
      }),
    );
    var data = await APIFunction().apiCall(apiName: Constants.home, context: Get.context!, params: formData, isLoading: isLoading);

    HomeModel model = HomeModel.fromJson(data);
    if (model.responseCode == 1) {
      homeData = model.data;
      bookHistories = model.data!.bookHistories!;
      finalBookHistories = model.data!.bookHistories!;
      if (textFieldClear) {
        searchField(search.text);
      }
      if (finalBookHistories.isEmpty) {
        noDataFound.value = Strings.noDataFound;
      }
      update();
    }
  }

  addUpdateBookApi({int bookId = 0}) async {
    FormData formData = FormData.fromMap({
      'name': addBookNameController.text.trim(),
      if (bookId != 0) 'book_id': bookId,
    });
    var data = await APIFunction().apiCall(apiName: Constants.addUpdateBook, context: Get.context!, params: formData);
    if (data['ResponseCode'] == 1) {
      Get.back();
      if (bookId != 0) {
        Get.back();
        Utils().showToast(message: Strings.bookNameUpdatedSuccessfully, context: Get.context!);
        homeApi();
      } else {
        Get.toNamed(Routes.DETAIL, arguments: {
          'bookId': data['data']['book_id'],
          'name': data['data']['name'],
        })?.then((value) => homeApi(isLoading: false));
      }
    } else {
      Utils().showToast(message: data['ResponseMsg'], context: Get.context!);
    }
  }

  deleteBookApi({int bookId = 0}) async {
    FormData formData = FormData.fromMap({
      if (bookId != 0) 'book_id': bookId,
    });
    var data = await APIFunction().apiCall(apiName: Constants.deleteBook, context: Get.context!, params: formData);

    Utils().showToast(message: data['ResponseMsg'], context: Get.context!);
    if (data['ResponseCode'] == 1) {
      Get.back();
      homeApi();
    }
  }

  searchField(String value) {
    finalBookHistories = [];
    bookHistories.forEach((element) {
      if (element.name!.toLowerCase().contains(value)) {
        finalBookHistories.add(element);
      }
      if (finalBookHistories.length <= 3) {}
    });
    update();
  }

  addBookSheet({int bookId = 0}) async {
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
                            bookId != 0 ? Strings.editCashBook : Strings.addNewBook,
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
                          CommonAppTextField(
                            controller: addBookNameController,
                            hintText: Strings.enterBookName,
                            labelText: Strings.enterBookName,
                            focusNode: searchNode,
                            onChanged: (p0) {
                              setState(() {});
                            },
                          ),
                          // Container(
                          //   height: 55.h,
                          //   child: TextField(
                          //     controller: addBookNameController,
                          //     focusNode: searchNode,
                          //     cursorColor: AppColors.primary,
                          //     style: AppTextStyle(textFamily: FontFamily.medium, textSize: 16.sp, textColor: AppColors.blackColor),
                          //     decoration: InputDecoration(
                          //       border: OutlineInputBorder(),
                          //       focusedBorder: const OutlineInputBorder(
                          //         borderSide: const BorderSide(color: AppColors.primary, width: 1.3),
                          //       ),
                          //       labelStyle: AppTextStyle(
                          //           textFamily: FontFamily.medium,
                          //           textSize: 16.sp,
                          //           textColor: addBookNameController.text.trim().isNotEmpty ? AppColors.primary : AppColors.greyText),
                          //       labelText: Strings.enterBookName,
                          //       hintText: Strings.enterBookName,
                          //     ),
                          //     onChanged: (text) {
                          //       setState(() {});
                          //     },
                          //   ),
                          // ),
                          Visibility(
                            visible: bookId == 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                        addBookNameController.text = suggestionList[index].name!;
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
                              ],
                            ),
                          ),
                          40.verticalSpace,
                          CommonButton(
                            onTap: () {
                              if (addBookNameController.text.trim().isNotEmpty) {
                                addUpdateBookApi(bookId: bookId);
                              }
                            },
                            text: bookId != 0 ? Strings.save : Strings.addNewBook.toUpperCase(),
                            isLeftButton: bookId == 0,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            textColor: addBookNameController.text.trim().isNotEmpty ? AppColors.whiteColor : AppColors.greyText.withOpacity(0.9),
                            color: addBookNameController.text.trim().isNotEmpty ? AppColors.primary : AppColors.greyText.withOpacity(0.35),
                            leftIcon: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Icon(
                                Icons.add,
                                color: addBookNameController.text.trim().isNotEmpty ? AppColors.whiteColor : AppColors.greyText.withOpacity(0.9),
                              ),
                            ),
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
    ).then((value) {
      addBookNameController.text = '';
    });
    await Future.delayed(Duration(milliseconds: 100));
    FocusScope.of(Get.context!).requestFocus(searchNode);
  }

  getReportFileApi() async {
    printAction('----------------->>>>>>report pdf file');
    FormData formData = FormData.fromMap({});
    var data = await APIFunction().apiCall(apiName: Constants.getReportPDF, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      _launchUrl(data['data']['url']);
    } else {
      Utils().showToast(message: data['ResponseMsg'], context: Get.context!);
    }
    update();
  }

  Future<void> _launchUrl(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch');
    }
  }

  selectDateSheet() {
    Get.bottomSheet(
      GetBuilder<HomeController>(
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.r),
              ),
              color: AppColors.whiteColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 15.h, right: 15.h, bottom: 10.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close),
                      ),
                      10.horizontalSpace,
                      AppText(
                        "Select Data Filter",
                        color: AppColors.darkText,
                        fontFamily: FontFamily.semiBold,
                        fontSize: FontSize.s17,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.greyColor.withOpacity(0.2),
                  thickness: 1.h,
                ),
                5.verticalSpace,
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectDateFilter.length,
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        isSelected.value = index;
                        if (index == 3) {
                          datePickerDialog();
                        }
                        update();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.h),
                        color: index == isSelected.value ? AppColors.primary.withOpacity(0.2) : AppColors.whiteColor,
                        child: Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary, width: 1.h),
                                shape: BoxShape.circle,
                                color: AppColors.whiteColor,
                              ),
                              padding: EdgeInsets.all(2.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index == isSelected.value ? AppColors.primary : Colors.transparent,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            AppText(
                              isCustom.value
                                  ? index == 3
                                      ? "${DateFormat("dd MMM, yyy").format(selectedStartDate)} - ${DateFormat("dd MMM, yyy").format(selectedEndDate)}"
                                      : selectDateFilter[index]
                                  : selectDateFilter[index],
                              color: AppColors.darkText,
                              fontSize: FontSize.s16,
                              fontFamily: FontFamily.semiBold,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                10.verticalSpace,
                Divider(
                  color: AppColors.greyColor.withOpacity(0.2),
                  thickness: 1.h,
                ),
                5.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelected.value = -1;
                          finalSelected.value = isSelected.value;
                          selectedStartDate = DateTime.now();
                          selectedEndDate = DateTime.now();
                          update();
                          homeApi();
                          Get.back();
                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close,
                                color: isSelected.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                              ),
                              12.horizontalSpace,
                              AppText(
                                "CLEAR ALL",
                                color: isSelected.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                                fontFamily: FontFamily.medium,
                                fontSize: FontSize.s14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          finalSelected.value = isSelected.value;
                          homeApi();
                          Get.back();
                          update();
                        },
                        text: "APPLY",
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        color: isSelected.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                        textColor: isSelected.value < 0 ? AppColors.greyColor.withOpacity(0.8) : AppColors.whiteColor,
                      ),
                    ),
                    20.horizontalSpace,
                  ],
                ),
                (MediaQuery.of(Get.context!).padding.bottom + 5).verticalSpace
              ],
            ),
          );
        },
      ),
    );
  }

  datePickerDialog() {
    Get.dialog(
      Dialog(
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 15.h, right: 15.h, bottom: 10.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.close),
                        ),
                        10.horizontalSpace,
                        AppText(
                          "Custom Date",
                          color: AppColors.darkText,
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s17,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.greyColor.withOpacity(0.2),
                    thickness: 1.h,
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        selectStartDate(Get.context!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppText(
                              "Start Date",
                              color: AppColors.darkText,
                              fontSize: FontSize.s18,
                              fontFamily: FontFamily.semiBold,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_rounded,
                            color: AppColors.primary,
                          ),
                          5.horizontalSpace,
                          AppText(
                            DateFormat('dd/MM/yyyy').format(selectedStartDate).toString(),
                            color: AppColors.primary,
                            fontSize: FontSize.s16,
                            fontFamily: FontFamily.medium,
                          ),
                          10.horizontalSpace,
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        selectEndDate(Get.context!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppText(
                              "End Date",
                              color: AppColors.darkText,
                              fontSize: FontSize.s18,
                              fontFamily: FontFamily.semiBold,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_rounded,
                            color: AppColors.primary,
                          ),
                          5.horizontalSpace,
                          AppText(
                            DateFormat('dd/MM/yyyy').format(selectedEndDate).toString(),
                            color: AppColors.primary,
                            fontSize: FontSize.s16,
                            fontFamily: FontFamily.medium,
                          ),
                          10.horizontalSpace,
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: CommonButton(
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        onTap: () {
                          isCustom.value = true;
                          update();
                          Get.back();
                        },
                        text: "DONE"),
                  ),
                  15.verticalSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedStartDate, firstDate: DateTime(2000, 8), lastDate: DateTime(2030, 8));
    if (picked != null && picked != selectedStartDate) {
      print("picked -- $picked");
      selectedStartDate = picked;
      printAction('is this----------------->>>>>>${selectedStartDate.difference(selectedEndDate).inMinutes}');
      if (selectedStartDate.difference(selectedEndDate).inMinutes >= 0) {
        selectedEndDate = selectedStartDate;
        update();
        printAction('selectEndDate----------------->>>>>>${selectedEndDate}');
      }
      update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedEndDate, firstDate: selectedStartDate, lastDate: DateTime(2030, 8));
    if (picked != null && picked != selectedEndDate) {
      print("picked -- $picked");
      selectedEndDate = picked;
      update();
    }
  }

  Widget childPopup({int bookId = 0, String bookName = ''}) => PopupMenuButton<int>(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text(
              "Rename",
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Delete Book",
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        onSelected: (value) {
          if (value == 1) {
            addBookNameController.text = bookName;
            addBookSheet(bookId: bookId);
          } else {
            showConfirmDialog(Get.context!, Strings.deleteBook, Strings.doYouWantDeleteBook, Strings.delete, Strings.cancel, () {
              deleteBookApi(bookId: bookId);
            });
          }
        },
        elevation: 5,
        color: AppColors.whiteColor,
        child: const Icon(Icons.more_vert_outlined, color: AppColors.greyText),
      );
}
