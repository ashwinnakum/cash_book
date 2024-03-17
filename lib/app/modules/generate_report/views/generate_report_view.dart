import '../../../data/all.dart';
import '../controllers/generate_report_controller.dart';

class GenerateReportView extends GetView<GenerateReportController> {
  const GenerateReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GenerateReportController>(builder: (logic) {
      return CommonScreen(
        backgroundColor: AppColors.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.primary,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding: EdgeInsets.only(left: FontSize.defaultPadding, right: FontSize.defaultPadding, top: 12.h, bottom: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: AppColors.transparentColor,
                        child: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
                      )),
                  18.horizontalSpace,
                  AppText(
                    Strings.generateReport,
                    color: AppColors.whiteColor,
                    fontSize: FontSize.s18,
                    fontFamily: FontFamily.semiBold,
                  ),
                  Spacer(),
                  SizedBox(height: 30.h, width: 30.h),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
              child: AppText(
                Strings.generateReport,
                color: AppColors.whiteColor,
                fontSize: FontSize.s18,
                fontFamily: FontFamily.semiBold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
              child: AppText(
                Strings.selectReportType,
                color: AppColors.darkText,
                fontSize: FontSize.s16,
                fontFamily: FontFamily.semiBold,
              ),
            ),
            10.verticalSpace,
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                itemCount: controller.reportList.length,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.select = index;
                      if (index == controller.reportList.length - 1) {
                        controller.datePickerDialog();
                      }
                      controller.update();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
                      color: index == controller.select ? AppColors.primary.withOpacity(0.2) : AppColors.whiteColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20.h,
                            width: 20.h,
                            margin: EdgeInsets.only(top: 4.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary, width: 1.h),
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                            ),
                            padding: EdgeInsets.all(2.h),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == controller.select ? AppColors.primary : Colors.transparent,
                              ),
                            ),
                          ),
                          15.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                controller.reportList[index].name!,
                                color: AppColors.darkText,
                                fontSize: FontSize.s16,
                                fontFamily: FontFamily.semiBold,
                              ),
                              4.verticalSpace,
                              AppText(
                                controller.reportList[index].type!,
                                color: AppColors.greyColor.withOpacity(0.8),
                                fontSize: FontSize.s14,
                                fontFamily: FontFamily.medium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                Container(height: 1.h, color: Colors.grey.withOpacity(0.15), width: double.infinity),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                  child: CommonButton(
                    onTap: () {
                      Get.back();
                    },
                    text: Strings.generateExcel,
                    padding: EdgeInsets.symmetric(vertical: 16.5.h),
                    borderRadius: 6.r,
                    isLeftButton: true,
                    leftIcon: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Image.asset(ImagePath.imagesIcExcel, height: 20.h, width: 20.h),
                    ),
                    color: AppColors.transparentColor,
                    borderColor: AppColors.primary,
                    textColor: AppColors.primary,
                    border: Border.all(width: 1, color: AppColors.primary),
                  ),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                  child: CommonButton(
                    onTap: () {
                      Get.back();
                    },
                    text: Strings.generatePDF,
                    isLeftButton: true,
                    leftIcon: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Image.asset(ImagePath.imagesIcColorPdf, height: 20.h, width: 20.h),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 17.h),
                    borderRadius: 6.r,
                  ),
                ),
                (MediaQuery.of(context).padding.bottom + 5).verticalSpace
              ],
            )
          ],
        ),
      );
    });
  }
}
