import 'package:cash_book/app/commonWidget/dialog.dart';
import 'package:cash_book/app/modules/login/controllers/login_controller.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../data/all.dart';
import '../../../models/home_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (logic) {
          return CommonScreen(
            floatingActionButton: Obx(() {
              return FloatingActionButton.extended(
                onPressed: () async {
                  controller.addBookNameController.text = '';
                  controller.addBookSheet();
                },
                isExtended: controller.isScroll.value,
                extendedPadding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 22.h),
                shape: !controller.isScroll.value ? const CircleBorder() : RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
                label: AppText(Strings.addNewBook.toUpperCase(), color: AppColors.whiteColor, fontSize: 15.sp),
                backgroundColor: AppColors.primary,
                icon: const Icon(Icons.add, color: AppColors.whiteColor),
              );
            }),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  padding: EdgeInsets.only(left: FontSize.defaultPadding, right: FontSize.defaultPadding, top: 15.h, bottom: 13.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 30.h,
                        width: 30.h,
                        child: Image.asset(
                          ImagePath.imagesIcBook,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      15.horizontalSpace,
                      AppText(
                        Strings.account,
                        color: AppColors.whiteColor,
                        fontSize: FontSize.s18,
                        fontFamily: FontFamily.semiBold,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          controller.getReportFileApi();
                        },
                        child: SizedBox(
                          height: 30.h,
                          width: 30.h,
                          child: Image.asset(ImagePath.imagesIcRedPdf),
                        ),
                      ),
                      15.horizontalSpace,
                      GestureDetector(
                          onTap: () {
                            showConfirmDialog(Get.context!, Strings.logOut, Strings.doYouWantLogOut, Strings.logout, Strings.cancel, () async {
                              Loading.show();
                              await Future.delayed(Duration(milliseconds: 500));
                              GetStorageData().removeAllData();
                              Loading.dismiss();
                              Get.offAllNamed(Routes.LOGIN);
                            });
                          },
                          child: Icon(size: 30.h, Icons.logout, color: AppColors.whiteColor)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.whiteColor,
                    child: ListView(
                      controller: controller.scrollController,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 50.h),
                      children: [
                        Container(
                          color: Colors.transparent,
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
                                                  AppText(
                                                      controller.homeData != null
                                                          ? Utils().currencyFormatChange(amount: controller.homeData?.netBalance)
                                                          : '00',
                                                      fontFamily: FontFamily.semiBold,
                                                      fontSize: 17.sp),
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
                                                  controller.homeData != null ? Utils().currencyFormatChange(amount: controller.homeData?.totalIn) : '00',
                                                  fontFamily: FontFamily.semiBold,
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
                                                  controller.homeData != null ? Utils().currencyFormatChange(amount: controller.homeData?.totalOut) : '00',
                                                  fontFamily: FontFamily.semiBold,
                                                  fontSize: 15.sp,
                                                  color: AppColors.appRedColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.GENERATE_REPORT, arguments: 0);
                                        },
                                        child: Container(
                                          color: AppColors.transparentColor,
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        StickyHeader(
                          overlapHeaders: false,
                          header: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                10.verticalSpace,
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.transparentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                                    boxShadow: const [
                                      BoxShadow(color: Color(0x66B1BACD), blurRadius: 60, offset: Offset(0, 20), spreadRadius: -10),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: FontSize.defaultPadding, right: FontSize.defaultPadding),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextField(
                                          controller: controller.search,
                                          hintText: Strings.searchCustomer,
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(13.h),
                                            child: Image.asset(
                                              ImagePath.imagesIcDarkSearch,
                                              height: 16.h,
                                              width: 16.h,
                                              color: AppColors.primary.withOpacity(0.8),
                                            ),
                                          ),
                                          suffixIcon: Visibility(
                                            visible: controller.search.text.trim().isNotEmpty,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.search.text = '';
                                                controller.finalBookHistories = controller.bookHistories;
                                                controller.update();
                                              },
                                              child: Container(
                                                color: AppColors.transparentColor,
                                                child: Padding(
                                                  padding: EdgeInsets.all(13.h),
                                                  child: Icon(Icons.close, color: AppColors.greyText.withOpacity(0.8)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onChanged: (p0) => controller.searchField(p0),
                                        ),
                                      ),
                                      15.horizontalSpace,
                                      GestureDetector(
                                        onTap: () {
                                          controller.selectDateSheet();
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Column(
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
                                        ),
                                      ),
                                      5.horizontalSpace
                                    ],
                                  ),
                                ),
                                10.verticalSpace,
                              ],
                            ),
                          ),
                          content: controller.finalBookHistories.isNotEmpty
                              ? Column(
                                  children: [
                                    GroupedListView<BookHistories, String>(
                                      padding: EdgeInsets.only(top: 14.h, left: FontSize.defaultPadding, right: FontSize.defaultPadding),
                                      physics: NeverScrollableScrollPhysics(),
                                      reverse: true,
                                      shrinkWrap: true,
                                      elements: controller.finalBookHistories,
                                      groupBy: (bookHistories) => DateTime.parse(bookHistories.updatedAt!).toUtc().toString(),
                                      groupSeparatorBuilder: (String groupByValue) => Container(),
                                      itemBuilder: (context, element) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.DETAIL, arguments: {'bookId': element.bookId, 'name': element.name})?.then((value) {
                                              controller.homeApi(isLoading: false, textFieldClear: true);
                                            });
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
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          AppText(
                                                            element.name! ?? '',
                                                            color: AppColors.blackColor,
                                                            fontSize: 16.sp,
                                                            maxLines: 2,
                                                            fontFamily: FontFamily.medium,
                                                          ),
                                                          6.verticalSpace,
                                                          AppText(
                                                            '${element.createdAt == element.updatedAt ? '${Strings.createdOn}${Utils().timeAgoSinceDate(element.updatedAt!)}' : '${Strings.updatedOn}${Utils().timeAgoSinceDate(element.updatedAt!)}'}',
                                                            color: AppColors.greyText,
                                                            fontSize: 12.5.sp,
                                                            fontFamily: FontFamily.regular,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    AppText(
                                                      element.netBalance == null ? '00' : Utils().currencyFormatChange(amount: element.netBalance),
                                                      color: element.netBalance == null
                                                          ? AppColors.green
                                                          : element.netBalance! <= 0
                                                              ? AppColors.appRedColor
                                                              : AppColors.appGreenColor,
                                                      fontSize: 14.sp,
                                                      fontFamily: FontFamily.medium,
                                                    ),
                                                    5.horizontalSpace,
                                                    controller.childPopup(bookId: element.bookId!, bookName: element.name!)
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 46.h, top: 17.h, bottom: 17.h),
                                                  height: 0.8.h,
                                                  color: AppColors.greyText.withOpacity(0.2),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    if (controller.search.text.trim().isNotEmpty && controller.finalBookHistories.length <= 10)
                                      (Get.height - 270).verticalSpace,
                                  ],
                                )
                              : Padding(
                                  padding: EdgeInsets.only(bottom: Get.height - 250.h, top: 250.h),
                                  child: Center(
                                    child: SizedBox(
                                      child: AppText(
                                        controller.noDataFound.value,
                                        color: AppColors.greyText,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
