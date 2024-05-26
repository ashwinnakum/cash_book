import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/all.dart';
import '../../../models/book_detail_model.dart';

class DetailController extends GetxController {
  TextEditingController search = TextEditingController();
  RxInt isSelected1 = (-1).obs;
  RxInt isFinalSelected1 = (-1).obs;
  RxInt isSelected2 = (-1).obs;
  RxInt isFinalSelected2 = (-1).obs;

  RxBool isCustom = false.obs;
  int bookId = 0;
  String name = '';
  BookDetailModel? bookDetailModel;
  List<BookHistories> bookHistories = [];
  List<BookHistories> finalBookHistories = [];
  var selectMode = false;

  // RxString noDataFound = ''.obs;

  List<CommonModel> filterList = [
    CommonModel(
      name: "Select Date",
      isNetwork: true.obs,
    ),
    CommonModel(
      name: "Entry Type",
      isNetwork: false.obs,
    ),
  ];

  List selectDateFilter = [
    "Today",
    "Last Month",
    "Last Year",
    "Custom",
  ];

  List entryTypeFilter = [
    "All",
    "Cash In",
    "Cash Out",
  ];

  @override
  void onInit() {
    if (Get.arguments != null) {
      bookId = Get.arguments['bookId'];
      name = Get.arguments['name'];
    }
    printAction('book id is ----------------->>>>>>${bookId}');
    if (bookId != 0) {
      getBookDetails();
    }
    super.onInit();
  }

  getBookDetails({bool isClearFilter = false}) async {
    String startDate = '';
    String endDate = '';
    if (isFinalSelected1.value != -1) {
      if (isFinalSelected1.value != 3) {
        endDate = Utils().changeDateFormat(date: DateTime.now(), outputFormat: 'yyyy-MM-dd');
        startDate = Utils().changeDateFormat(
            date: isFinalSelected1.value == 0
                ? DateTime.now()
                : isFinalSelected1.value == 1
                    ? Jiffy.now().subtract(months: 1).dateTime
                    : Jiffy.now().subtract(years: 1).dateTime,
            outputFormat: 'yyyy-MM-dd');
      } else if (isFinalSelected1.value == 3) {
        startDate = Utils().changeDateFormat(date: selectedStartDate, outputFormat: 'yyyy-MM-dd');
        endDate = Utils().changeDateFormat(date: selectedEndDate, outputFormat: 'yyyy-MM-dd');
      }
    }

    FormData formData = FormData.fromMap({
      'book_id': bookId,
      if (isFinalSelected1.value != -1 && startDate.isNotEmpty && !isClearFilter) 'start_date': startDate,
      if (isFinalSelected1.value != -1 && endDate.isNotEmpty && !isClearFilter) 'end_date': endDate,
      if (isFinalSelected2.value != -1 && !isClearFilter)
        'cash_type': isFinalSelected2.value == 0
            ? 'all'
            : isFinalSelected2.value == 1
                ? 'in'
                : 'out'
    });
    var data = await APIFunction().apiCall(apiName: Constants.getBookDetails, context: Get.context!, params: formData);
    BookDetailModel model = BookDetailModel.fromJson(data);
    if (model.responseCode == 1) {
      bookDetailModel = model;
      bookHistories = model.data!.bookHistories!;
      finalBookHistories = model.data!.bookHistories!;
      if (isClearFilter) {
        isFinalSelected1.value = -1;
        isSelected1.value = -1;
        isFinalSelected2.value = -1;
        isSelected2.value = -1;
      }
    } else {
      Utils().showToast(message: model.responseMsg!, context: Get.context!);
    }
    update();
  }

  getReportFileApi() async {
    FormData formData = FormData.fromMap({'book_id': bookId});
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

  searchField(String value) {
    finalBookHistories = [];
    bookHistories.forEach((element) {
      if (element.remark!.toLowerCase().contains(value)) {
        finalBookHistories.add(element);
      }
    });
    update();
  }

  selectDateSheet() {
    Get.bottomSheet(
      GetBuilder<DetailController>(
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
                        isSelected1.value = index;
                        if (index == 3) {
                          datePickerDialog();
                        }
                        update();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.h),
                        color: index == isSelected1.value ? AppColors.primary.withOpacity(0.2) : AppColors.whiteColor,
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
                                  color: index == isSelected1.value ? AppColors.primary : Colors.transparent,
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
                          isSelected1.value = -1;
                          isFinalSelected1.value = -1;
                          selectedStartDate = DateTime.now();
                          selectedEndDate = DateTime.now();
                          getBookDetails();
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
                                color: isSelected1.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                              ),
                              12.horizontalSpace,
                              AppText(
                                "CLEAR ALL",
                                color: isSelected1.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
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
                          isFinalSelected1.value = isSelected1.value;
                          getBookDetails();
                          Get.back();
                          update();
                        },
                        text: "APPLY",
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        color: isSelected1.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                        textColor: isSelected1.value < 0 ? AppColors.greyColor.withOpacity(0.8) : AppColors.whiteColor,
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

  entryTypeSheet() {
    Get.bottomSheet(
      GetBuilder<DetailController>(
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
                        "Select Entry Type Filter",
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
                  itemCount: entryTypeFilter.length,
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        isSelected2.value = index;
                        update();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.h),
                        color: index == isSelected2.value ? AppColors.primary.withOpacity(0.2) : AppColors.whiteColor,
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
                                  color: index == isSelected2.value ? AppColors.primary : Colors.transparent,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            AppText(
                              entryTypeFilter[index],
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
                          isSelected2.value = -1;
                          isFinalSelected2.value = -1;
                          getBookDetails();
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
                                color: isSelected2.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                              ),
                              12.horizontalSpace,
                              AppText(
                                "CLEAR ALL",
                                color: isSelected2.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
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
                          isFinalSelected2.value = isSelected2.value;
                          getBookDetails();
                          Get.back();
                          update();
                        },
                        text: "APPLY",
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        color: isSelected2.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                        textColor: isSelected2.value < 0 ? AppColors.greyColor.withOpacity(0.8) : AppColors.whiteColor,
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
        child: GetBuilder<DetailController>(
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

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedStartDate, firstDate: DateTime(2000, 8), lastDate: DateTime(2030, 8));
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
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedEndDate, firstDate: selectedStartDate, lastDate: DateTime(2030, 8));
    if (picked != null && picked != selectedEndDate) {
      print("picked -- $picked");
      selectedEndDate = picked;
      update();
    }
  }
}
