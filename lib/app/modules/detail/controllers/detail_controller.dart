import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../data/all.dart';

class DetailController extends GetxController {
  TextEditingController search = TextEditingController();
  RxInt isSelected = (-1).obs;
  RxInt isSelected2 = (-1).obs;
  RxBool isCustom = false.obs;

  List<CommonModel> entriesList = [
    CommonModel(name: "24 February 2024", list: [
      CommonModel(
        name: "Hair cut",
        price: "300",
        id: "-3000",
        icon: "at 5:04 pm",
      ),
      CommonModel(
        name: "Hair cut",
        price: "300",
        id: "-3000",
        icon: "at 5:04 pm",
      ),
    ]),
    CommonModel(name: "23 February 2024", list: [
      CommonModel(
        name: "Hair cut",
        price: "300",
        id: "-3000",
        icon: "at 5:04 pm",
      ),
      CommonModel(
        name: "Hair cut",
        price: "300",
        id: "-3000",
        icon: "at 5:04 pm",
      ),
    ]),
    CommonModel(name: "22 February 2024", list: [
      CommonModel(
        name: "Hair cut",
        price: "300",
        id: "-3000",
        icon: "at 5:04 pm",
      ),
      CommonModel(
        name: "Hair cut",
        price: "300",
        id: "-3000",
        icon: "at 5:04 pm",
      ),
    ]),
  ];

  List<CommonModel> filterList = [
    CommonModel(
      name: "Select Date",
      isCheck: true.obs,
    ),
    CommonModel(
      name: "Entry Type",
      isCheck: false.obs,
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
                                  ? "${DateFormat("dd, MMM, yyy").format(selectedStartDate)} - ${DateFormat("dd, MMM, yyy").format(selectedEndDate)}"
                                  :selectDateFilter[index]
                                  :selectDateFilter[index],
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
                          isSelected.value = (-1);
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
                                fontSize: FontSize.s16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Get.back();
                          update();
                        },
                        text: "APPLY",
                        color: isSelected.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                        textColor: isSelected.value < 0 ? AppColors.greyColor.withOpacity(0.8) : AppColors.whiteColor,
                      ),
                    ),
                    20.horizontalSpace,
                  ],
                ),
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
                          isSelected2.value = (-1);
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
                                fontSize: FontSize.s16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Get.back();
                          update();
                        },
                        text: "APPLY",
                        color: isSelected2.value < 0 ? AppColors.greyColor.withOpacity(0.2) : AppColors.primary,
                        textColor: isSelected2.value < 0 ? AppColors.greyColor.withOpacity(0.8) : AppColors.whiteColor,
                      ),
                    ),
                    20.horizontalSpace,
                  ],
                ),
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
                  CommonButton(onTap: () {
                    isCustom.value = true;
                    update();
                    Get.back();
                  }, text: "DONE"),
                  20.verticalSpace,
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
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime.now()
    );
    if (picked != null && picked != selectedStartDate) {
      print("picked -- $picked");
      selectedStartDate = picked;
      update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: selectedStartDate,
        lastDate: DateTime.now()
    );
    if (picked != null && picked != selectedEndDate) {
      print("picked -- $picked");
      selectedEndDate = picked;
      update();
    }
  }
}
