import '../../../data/all.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomNavigationBarWidget: Container(
        color: AppColors.whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppRichText(
              firstText: Strings.donTHaveAnAccount,
              secondText: Strings.signUp,
              onTap: () {
                Get.offAndToNamed(Routes.SIGNUP);
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
                                  Strings.signIn,
                                  color: AppColors.darkText,
                                  fontSize: 30.sp,
                                  fontFamily: FontFamily.medium,
                                ),
                                10.verticalSpace,
                                AppText(
                                  Strings.pleaseSign,
                                  color: AppColors.greyText,
                                  fontSize: 16.sp,
                                  fontFamily: FontFamily.medium,
                                ),
                                30.verticalSpace,
                                CommonTextField(
                                  controller: controller.phoneNo,
                                  hintText: Strings.mobileNumber,
                                  textInputAction: TextInputAction.next,
                                ),
                                20.verticalSpace,
                                CommonTextField(
                                  controller: controller.password,
                                  hintText: Strings.password,
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {
                                    controller.validation();
                                  },
                                ),
                                20.verticalSpace,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.phoneNo.clear();
                                      controller.password.clear();
                                      Get.toNamed(Routes.FORGOT_PASSWORD);
                                    },
                                    child: AppText(
                                      Strings.forgotPasswordD,
                                      color: AppColors.primary,
                                      textAlign: TextAlign.right,
                                      fontSize: 16.sp,
                                      fontFamily: FontFamily.medium,
                                    ),
                                  ),
                                ),
                                30.verticalSpace,
                                CommonButton(
                                    onTap: () {
                                      controller.validation();
                                    },
                                    text: Strings.signIn.toUpperCase())
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
