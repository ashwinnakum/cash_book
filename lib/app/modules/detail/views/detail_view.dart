import 'package:grouped_list/grouped_list.dart';
import 'package:lottie/lottie.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../data/all.dart';
import '../../../models/book_detail_model.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      builder: (controller) {
        return CommonScreen(
          backgroundColor: AppColors.whiteColor,
          bottomNavigationBarWidget: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: controller.bookDetailModel != null &&
                      controller.bookDetailModel!.data!.bookHistories!.isEmpty &&
                      controller.isFinalSelected1.value == -1 &&
                      controller.isFinalSelected2.value == -1,
                  child: Column(
                    children: [
                      20.verticalSpace,
                      AppText(
                        Strings.addYourFirstEntry,
                        color: AppColors.darkText,
                        fontSize: FontSize.s20,
                        fontFamily: FontFamily.semiBold,
                      ),
                      10.verticalSpace,
                      Lottie.asset(
                        ImagePath.imagesDownArrow,
                        height: 70.h,
                        width: 70.h,
                        fit: BoxFit.cover,
                        delegates: LottieDelegates(
                          values: [
                            ValueDelegate.color(
                              const ['**', 'wave_2 Outlines', '**'],
                              value: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppRichText(
                            fontSize: FontSize.s16,
                            firstText: Strings.record,
                            firstTextColor: AppColors.greyColor,
                            secondText: Strings.income,
                            secondTextFontFamily: FontFamily.semiBold,
                            secondTextColor: AppColors.green,
                          ),
                          AppRichText(
                            fontSize: FontSize.s16,
                            firstText: Strings.record,
                            firstTextColor: AppColors.greyColor,
                            secondText: Strings.expense,
                            secondTextFontFamily: FontFamily.semiBold,
                            secondTextColor: AppColors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
                Row(
                  children: [
                    20.horizontalSpace,
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Get.toNamed(Routes.ADD_DETAIL, arguments: {
                            Strings.withScreen: Strings.add,
                            Strings.isPlus: Strings.inKey,
                            'bookId': controller.bookId,
                          })!
                              .then((value) {
                            Utils().appStatusBar();
                            controller.update();
                            if (value is bool && value) {
                              controller.getBookDetails();
                            }
                          });
                        },
                        text: Strings.cashIn,
                        padding: EdgeInsets.all(12.h),
                        fontSize: FontSize.s15,
                        isLeftButton: true,
                        leftIcon: Padding(
                            padding: EdgeInsets.only(right: 6.w),
                            child: Icon(
                              Icons.add,
                              size: 25.h,
                              color: AppColors.whiteColor,
                            )),
                        color: AppColors.green,
                      ),
                    ),
                    20.horizontalSpace,
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Get.toNamed(Routes.ADD_DETAIL, arguments: {
                            Strings.withScreen: Strings.add,
                            Strings.isPlus: Strings.outKey,
                            'bookId': controller.bookId,
                          })!
                              .then((value) {
                            Utils().appStatusBar();
                            controller.update();
                            if (value is bool && value) {
                              controller.getBookDetails();
                            }
                          });
                        },
                        text: Strings.cashOut,
                        isLeftButton: true,
                        leftIcon: Padding(
                            padding: EdgeInsets.only(right: 6.w),
                            child: Icon(
                              Icons.remove,
                              size: 25.h,
                              color: AppColors.whiteColor,
                            )),
                        padding: EdgeInsets.all(12.h),
                        fontSize: FontSize.s15,
                        color: AppColors.red,
                      ),
                    ),
                    20.horizontalSpace,
                  ],
                ),
                10.verticalSpace,
              ],
            ),
          ),
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
                      child: Container(
                        color: Colors.transparent,
                        child: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
                      ),
                    ),
                    18.horizontalSpace,
                    Expanded(
                      child: AppText(
                        controller.name,
                        maxLines: 2,
                        color: AppColors.whiteColor,
                        fontSize: FontSize.s18,
                        fontFamily: FontFamily.semiBold,
                      ),
                    ),
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
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.greBackgroundColor,
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
                                                AppText(
                                                  controller.bookDetailModel != null
                                                      ? Utils().currencyFormatChange(amount: controller.bookDetailModel?.data?.netBalance)
                                                      : '00',
                                                  fontFamily: FontFamily.semiBold,
                                                  fontSize: 17.sp,
                                                ),
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
                                                controller.bookDetailModel != null
                                                    ? Utils().currencyFormatChange(amount: controller.bookDetailModel?.data?.totalIn)
                                                    : '00',
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
                                                controller.bookDetailModel != null
                                                    ? Utils().currencyFormatChange(amount: controller.bookDetailModel?.data?.totalOut)
                                                    : '00',
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
                                        Get.toNamed(Routes.GENERATE_REPORT, arguments: controller.bookId);
                                      },
                                      child: Container(
                                        height: 45.h,
                                        color: Colors.transparent,
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
                      controller.bookHistories.isNotEmpty
                          ? Column(
                              children: [
                                StickyHeader(
                                  header: Container(
                                    color: AppColors.greBackgroundColor,
                                    child: Column(
                                      children: [
                                        10.verticalSpace,
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
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
                                                      color: AppColors.primary,
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
                                            ],
                                          ),
                                        ),
                                        10.verticalSpace,
                                        SizedBox(
                                          height: 40.h,
                                          width: double.infinity,
                                          child: ListView.builder(
                                            itemCount: controller.filterList.length,
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.only(left: 20.h, right: 20.h),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              CommonModel model = controller.filterList[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.isSelected1.value = (-1);
                                                  if (index == 0) {
                                                    controller.isCustom.value = false;
                                                    controller.selectDateSheet();
                                                    controller.update();
                                                  } else {
                                                    controller.entryTypeSheet();
                                                  }
                                                },
                                                child: Container(
                                                  height: 50,
                                                  margin: EdgeInsets.only(right: 8.h),
                                                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12.r),
                                                    border: Border.all(color: AppColors.greyText),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      model.isNetwork!.value
                                                          ? Icon(
                                                              Icons.calendar_month,
                                                              size: 15.h,
                                                            )
                                                          : 0.verticalSpace,
                                                      4.horizontalSpace,
                                                      AppText(
                                                        index == 0
                                                            ? controller.isFinalSelected1.value != (-1)
                                                                ? controller.selectDateFilter[controller.isFinalSelected1.value]
                                                                : model.name ?? ""
                                                            : controller.isFinalSelected2.value != (-1)
                                                                ? controller.entryTypeFilter[controller.isFinalSelected2.value]
                                                                : model.name ?? "",
                                                        fontSize: FontSize.s14,
                                                        color: AppColors.darkText,
                                                        fontFamily: FontFamily.regular,
                                                      ),
                                                      4.horizontalSpace,
                                                      Icon(Icons.arrow_drop_down),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        10.verticalSpace,
                                      ],
                                    ),
                                  ),
                                  content: Column(
                                    children: [
                                      8.verticalSpace,
                                      Visibility(
                                        visible: controller.finalBookHistories.isNotEmpty,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Divider(
                                                  color: AppColors.greyText.withOpacity(0.5),
                                                  thickness: 0.5.h,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                              child: AppText(
                                                "Showing ${controller.finalBookHistories.length} entries",
                                                color: AppColors.greyText,
                                                fontSize: FontSize.s14,
                                                fontFamily: FontFamily.medium,
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Divider(
                                                  height: 0,
                                                  color: AppColors.greyText.withOpacity(0.5),
                                                  thickness: 0.5.h,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      controller.finalBookHistories.isEmpty && controller.bookDetailModel != null
                                          ? Padding(
                                              padding: EdgeInsets.only(top: 100.h),
                                              child: Center(
                                                child: AppText(
                                                  Strings.noDataFound,
                                                  color: AppColors.greyText,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            )
                                          : Column(
                                              children: [
                                                GroupedListView<BookHistories, String>(
                                                  padding: EdgeInsets.only(top: 5.h),
                                                  physics: NeverScrollableScrollPhysics(),
                                                  reverse: true,
                                                  shrinkWrap: true,
                                                  elements: controller.finalBookHistories,
                                                  groupBy: (bookHistories) => Utils().changeDateFormat(
                                                      date: DateTime.parse('${bookHistories.entryDate!}' ' ${bookHistories.entryTime}'),
                                                      outputFormat: 'yyyy-MM-dd 00:00:00'),
                                                  groupSeparatorBuilder: (String groupByValue) => Padding(
                                                    padding: EdgeInsets.only(left: 20.h, top: 12.h, bottom: 16.h),
                                                    child: AppText(
                                                      '${Utils().changeDateFormat(date: DateTime.parse(groupByValue), outputFormat: 'dd MMM yyyy')}',
                                                      fontFamily: FontFamily.semiBold,
                                                      color: AppColors.greyText,
                                                      fontSize: FontSize.s14,
                                                    ),
                                                  ),
                                                  itemBuilder: (context, element) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(Routes.ADD_DETAIL, arguments: {
                                                          Strings.withScreen: Strings.edit,
                                                          Strings.isPlus: element.cashType,
                                                          'bookingModel': element
                                                        })!
                                                            .then((value) {
                                                          Utils().appStatusBar();
                                                          controller.update();
                                                          if (value is bool && value) {
                                                            controller.getBookDetails();
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        color: AppColors.whiteColor,
                                                        margin: EdgeInsets.only(bottom: 10.h),
                                                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            10.verticalSpace,
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(8.r),
                                                                    color: AppColors.skyColor.withOpacity(0.15),
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 7.h),
                                                                  child: AppText(
                                                                    "Cash",
                                                                    color: AppColors.darkSky,
                                                                    fontSize: FontSize.s14,
                                                                    fontFamily: FontFamily.semiBold,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      AppText(
                                                                        '${Utils().currencyFormatChange(amount: element.amount)}' ?? "N/A",
                                                                        color:
                                                                            element.cashType == Strings.outKey ? AppColors.marron : AppColors.green,
                                                                        fontFamily: FontFamily.bold,
                                                                        fontSize: FontSize.s16,
                                                                      ),
                                                                      5.verticalSpace,
                                                                      AppText(
                                                                        "Balance: ${'${element.balance}' ?? "N/A"}",
                                                                        color: AppColors.greyText,
                                                                        fontFamily: FontFamily.medium,
                                                                        fontSize: FontSize.s14,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            8.verticalSpace,
                                                            AppText(
                                                              element.remark ?? "",
                                                              color: AppColors.darkText,
                                                              fontSize: FontSize.s14,
                                                              fontFamily: FontFamily.medium,
                                                            ),
                                                            7.verticalSpace,
                                                            Divider(
                                                              color: AppColors.greyColor.withOpacity(0.3),
                                                              thickness: 0.5.h,
                                                            ),
                                                            7.verticalSpace,
                                                            Row(
                                                              children: [
                                                                AppText(
                                                                  "${Strings.entryByYou} ",
                                                                  color: AppColors.entryTextColor,
                                                                  fontFamily: FontFamily.bold,
                                                                  fontSize: FontSize.s14,
                                                                ),
                                                                5.horizontalSpace,
                                                                AppText(
                                                                  Utils().changeDateFormat(
                                                                          date: DateTime.parse('${element.entryDate}' ' ${'${element.entryTime}'}'),
                                                                          outputFormat: 'dd MMM yyyy, hh:mm:a') ??
                                                                      "",
                                                                  color: AppColors.greyText,
                                                                  fontFamily: FontFamily.medium,
                                                                  fontSize: FontSize.s14,
                                                                ),
                                                              ],
                                                            ),
                                                            12.verticalSpace,
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                if (controller.search.text.trim().isNotEmpty && controller.finalBookHistories.length <= 10)
                                                  (Get.height - 270).verticalSpace,
                                              ],
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : controller.bookDetailModel != null &&
                                  controller.bookDetailModel!.data!.bookHistories!.isEmpty &&
                                  (controller.isFinalSelected1.value != -1 || controller.isFinalSelected2.value != -1)
                              ? Padding(
                                  padding: EdgeInsets.only(top: 150.h),
                                  child: Column(
                                    children: [
                                      AppText(
                                        Strings.noEntriesFound,
                                        fontFamily: FontFamily.semiBold,
                                        fontSize: 14.sp,
                                        textAlign: TextAlign.center,
                                        color: AppColors.darkText.withOpacity(0.7),
                                      ),
                                      8.verticalSpace,
                                      GestureDetector(
                                        onTap: () {
                                          controller.getBookDetails(isClearFilter: true);
                                        },
                                        child: Container(
                                          color: AppColors.transparentColor,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color: AppColors.primary,
                                                size: 26.h,
                                              ),
                                              6.horizontalSpace,
                                              AppText(
                                                Strings.clearFilters,
                                                fontFamily: FontFamily.semiBold,
                                                fontSize: 17.sp,
                                                letterSpacing: 1.2,
                                                color: AppColors.primary,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
