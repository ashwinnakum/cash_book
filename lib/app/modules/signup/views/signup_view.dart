import '../../../data/all.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomNavigationBarWidget: Container(
        color: AppColors.whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppRichText(
              firstText: Strings.alreadyHaveAnAccount,
              secondText: Strings.signIn,
              onTap: () {
                Get.offAndToNamed(Routes.LOGIN);
              },
            ),
            MediaQuery.paddingOf(context).bottom.verticalSpace
          ],
        ),
      ),
      child: Container(
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Container(
                          height: 270.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: FontSize.defaultPadding, right: FontSize.defaultPadding, top: 160.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(20.r)),
                            boxShadow: const [
                              BoxShadow(color: Color(0x66B1BACD), blurRadius: 60, offset: Offset(0, 20), spreadRadius: -10),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: FontSize.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  Strings.signUp,
                                  color: AppColors.darkText,
                                  fontSize: 30.sp,
                                  fontFamily: FontFamily.medium,
                                ),
                                10.verticalSpace,
                                AppText(
                                  Strings.pleaseUp,
                                  color: AppColors.greyText,
                                  fontSize: 16.sp,
                                  fontFamily: FontFamily.medium,
                                ),
                                30.verticalSpace,
                                CommonTextField(
                                  controller: controller.name,
                                  hintText: Strings.name,
                                  textInputAction: TextInputAction.next,
                                ),
                                20.verticalSpace,
                                CommonTextField(
                                  controller: controller.phoneNo,
                                  hintText: Strings.mobileNumber,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                ),
                                20.verticalSpace,
                                CommonTextField(
                                  controller: controller.password,
                                  hintText: Strings.password,
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {},
                                ),
                                20.verticalSpace,
                                CommonTextField(
                                  controller: controller.confirmPassword,
                                  hintText: Strings.confirmPassword,
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {},
                                ),
                                30.verticalSpace,
                                CommonButton(
                                    onTap: () {
                                      controller.validation();
                                    },
                                    text: Strings.signUp.toUpperCase())
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
