import '../../../data/all.dart';
import '../controllers/add_detail_controller.dart';

class AddDetailView extends GetView<AddDetailController> {
  const AddDetailView({Key? key}) : super(key: key);

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
                  controller.withScreen == Strings.cashIn ? Strings.addCashInEntry : Strings.addCashOutEntry,
                  color: controller.withScreen == Strings.cashIn ? AppColors.whiteColor : AppColors.red,
                  fontSize: FontSize.s18,
                  fontFamily: FontFamily.semiBold,
                ),
                Spacer(),
                SizedBox(height: 30.h, width: 30.h),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
              physics: ScrollPhysics(),
              children: [
                20.verticalSpace,
                CommonTextField(
                  controller: controller.addAmount,
                  hintText: Strings.amount,
                  helperText: 'isLAble text',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
