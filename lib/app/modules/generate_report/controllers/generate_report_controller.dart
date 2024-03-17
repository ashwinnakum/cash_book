import 'package:cash_book/app/data/all.dart';
import 'package:intl/intl.dart';

class GenerateReportController extends GetxController {
  var select;
  List<CommonModel> reportList = [
    CommonModel(name: Strings.allEntriesRepost, type: Strings.listOffAllEntries),
    CommonModel(name: Strings.todayReport, type: Strings.todayInOutBalance),
    CommonModel(name: Strings.lastMonth, type: Strings.lastMonthInOutBalance),
    CommonModel(name: Strings.lastYear, type: Strings.lastYearInOutBalance),
    CommonModel(name: Strings.customDate, type: Strings.customInOutBalance),
  ];

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  RxBool isCustom = false.obs;

  datePickerDialog() {
    Get.dialog(
      Dialog(
        child: GetBuilder<GenerateReportController>(
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
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedStartDate, firstDate: DateTime(2000, 8), lastDate: DateTime.now());
    if (picked != null && picked != selectedStartDate) {
      print("picked -- $picked");
      selectedStartDate = picked;
      update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedEndDate, firstDate: selectedStartDate, lastDate: DateTime.now());
    if (picked != null && picked != selectedEndDate) {
      print("picked -- $picked");
      selectedEndDate = picked;
      update();
    }
  }
}
