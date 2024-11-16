import '../../../data/all.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      child: Container(
        color: AppColors.whiteColor,
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
                            Strings.setNewPassword,
                            color: AppColors.darkText,
                            fontSize: 30.sp,
                            fontFamily: FontFamily.medium,
                          ),
                          10.verticalSpace,
                          AppText(
                            Strings.pleaseEnterNewPasswordToContinue,
                            color: AppColors.greyText,
                            fontSize: 16.sp,
                            fontFamily: FontFamily.medium,
                          ),
                          30.verticalSpace,
                          CommonTextField(
                            controller: controller.newPasswordController,
                            hintText: Strings.newPassword,
                            textInputAction: TextInputAction.next,
                          ),
                          20.verticalSpace,
                          CommonTextField(
                            controller: controller.confirmPasswordController,
                            hintText: Strings.confirmNewPassword,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {},
                          ),
                          30.verticalSpace,
                          CommonButton(
                              onTap: () {
                                controller.validation();
                              },
                              text: Strings.save.toUpperCase())
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Utils().hideKeyboard();

                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.paddingOf(context).top + 20.h,
                        left: FontSize.defaultPadding,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                        size: 26.h,
                      ),
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