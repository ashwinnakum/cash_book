import '../../../data/all.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      child: Column(
        children: [
          Container(
            color: AppColors.primary,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding: EdgeInsets.only(left: FontSize.defaultPadding, right: FontSize.defaultPadding, top: 12.h, bottom: 13.h),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back, color: AppColors.whiteColor)),
                18.horizontalSpace,
                AppText(
                  Strings.account,
                  color: AppColors.whiteColor,
                  fontSize: FontSize.s18,
                  fontFamily: FontFamily.semiBold,
                ),
                const Spacer(),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CommonImage(
                    imageName: ImagePath.imagesIcBusiness,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.whiteColor,
              child: ListView(
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 240.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                            height: 200.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.all(Radius.circular(20.r)),
                              boxShadow: const [
                                BoxShadow(color: Color(0x66B1BACD), blurRadius: 60, offset: Offset(0, 20), spreadRadius: -10),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 45.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                                        child: Row(
                                          children: [
                                            AppText(
                                              Strings.netBalance,
                                              fontFamily: FontFamily.semiBold,
                                              fontSize: 17.sp,
                                            ),
                                            const Spacer(),
                                            AppText('-1,000', fontFamily: FontFamily.medium, fontSize: 17.sp),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 0.8.h,
                                        color: AppColors.greyText.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                                      child: Row(
                                        children: [
                                          AppText(
                                            Strings.totalIn,
                                            fontFamily: FontFamily.semiBold,
                                            fontSize: 15.sp,
                                          ),
                                          const Spacer(),
                                          AppText(
                                            '5,000',
                                            fontFamily: FontFamily.medium,
                                            fontSize: 15.sp,
                                            color: AppColors.appGreenColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    15.verticalSpace,
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                                      child: Row(
                                        children: [
                                          AppText(
                                            Strings.totalOut,
                                            fontFamily: FontFamily.semiBold,
                                            fontSize: 15.sp,
                                          ),
                                          const Spacer(),
                                          AppText(
                                            '6,000',
                                            fontFamily: FontFamily.medium,
                                            fontSize: 15.sp,
                                            color: AppColors.appRedColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 45.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 0.8.h,
                                        color: AppColors.greyText.withOpacity(0.2),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AppText(
                                              Strings.viewReports,
                                              fontFamily: FontFamily.semiBold,
                                              fontSize: 17.sp,
                                              color: AppColors.primary,
                                              letterSpacing: 1.2,
                                            ),
                                            6.horizontalSpace,
                                            Icon(
                                              Icons.navigate_next,
                                              color: AppColors.primary,
                                              size: 26.h,
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            controller: controller.search,
                            hintText: Strings.searchCustomer,
                            prefixIconData: Icons.search_rounded,
                          ),
                        ),
                        15.horizontalSpace,
                        Column(
                          children: [
                            Image.asset(
                              ImagePath.imagesIcFilter,
                              height: 25.h,
                              width: 25.h,
                              color: AppColors.primary,
                            ),
                            2.verticalSpace,
                            AppText(
                              'Filter',
                              fontSize: 10.sp,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                        5.horizontalSpace
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 20,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 20.h, left: FontSize.defaultPadding, right: FontSize.defaultPadding),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL);
                        },
                        child: Container(
                          color: AppColors.transparentColor,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 46.h,
                                    width: 46.h,
                                    padding: EdgeInsets.all(13.h),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacity(0.05)),
                                    child: Image.asset(
                                      ImagePath.imagesMyBook,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        'My Book',
                                        color: AppColors.blackColor,
                                        fontSize: 16.sp,
                                        fontFamily: FontFamily.medium,
                                      ),
                                      6.verticalSpace,
                                      AppText(
                                        'Updated on Feb 13 2024',
                                        color: AppColors.greyText,
                                        fontSize: 12.5.sp,
                                        fontFamily: FontFamily.regular,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  AppText(
                                    '-1,000',
                                    color: AppColors.appRedColor,
                                    fontSize: 14.sp,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  5.horizontalSpace,
                                  /*GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.more_vert_outlined,
                                      color: AppColors.greyText.withOpacity(0.8),
                                    ),
                                  )*/
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 46.h, top: 15.h, bottom: 15.h),
                                height: 0.8.h,
                                color: AppColors.greyText.withOpacity(0.2),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
