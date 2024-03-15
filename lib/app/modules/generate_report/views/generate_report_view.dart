import '../../../data/all.dart';
import '../controllers/generate_report_controller.dart';

class GenerateReportView extends GetView<GenerateReportController> {
  const GenerateReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      backgroundColor: AppColors.whiteColor,
      child: Column(
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
                    child: const Icon(Icons.arrow_back, color: AppColors.whiteColor)),
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
        ],
      ),
    );
  }
}
