import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/all.dart';
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
                if(isFirst.value)
                  20.verticalSpace,
                if(isFirst.value)
                  AppText(
                    Strings.addYourFirstEntry,
                    color: AppColors.darkText,
                    fontSize: FontSize.s20,
                    fontFamily: FontFamily.semiBold,
                  ),
                if(isFirst.value)
                  20.verticalSpace,
                if(isFirst.value)
                  Icon(Icons.arrow_downward_outlined, color: AppColors.primary,),
                if(isFirst.value)
                  30.verticalSpace,
                if(isFirst.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppRichText(
                        fontSize: FontSize.s16,
                        firstText: Strings.record,
                        firstTextColor: AppColors.greyColor,
                        secondText: Strings.income,
                        secondTextColor: AppColors.green,
                      ),
                      AppRichText(
                        fontSize: FontSize.s16,
                        firstText: Strings.record,
                        firstTextColor: AppColors.greyColor,
                        secondText: Strings.expense,
                        secondTextColor: AppColors.red,
                      ),
                    ],
                  ),
                10.verticalSpace,
                Row(
                  children: [
                    20.horizontalSpace,
                    Expanded(
                      child: CommonButton(onTap: () {
                        isFirst.value = false;
                        controller.update();
                      },
                        text: Strings.cashIn,
                        padding: EdgeInsets.all(12.h),
                        fontSize: FontSize.s18,
                        color: AppColors.green,
                      ),
                    ),
                    20.horizontalSpace,
                    Expanded(
                      child: CommonButton(onTap: () {
                        isFirst.value = false;
                        controller.update();
                        },
                        text: Strings.cashOut,
                        padding: EdgeInsets.all(12.h),
                        fontSize: FontSize.s18,
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
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .padding
                    .top),
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
                  color: AppColors.greyColor.withOpacity(0.05),
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
                      10.verticalSpace,
                      SizedBox(
                        height: 30.h,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: controller.filterList.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 20.h,right: 20.h),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            CommonModel model = controller.filterList[index];
                            return GestureDetector(
                              onTap: () {
                                controller.isSelected.value = (-1);
                                if(index == 0)
                                  {
                                    controller.isCustom.value  = false;
                                    controller.selectDateSheet();
                                    controller.update();
                                  }
                                else
                                  {
                                    controller.entryTypeSheet();
                                  }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 8.h),
                                padding: EdgeInsets.symmetric(horizontal: 5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: AppColors.greyText),
                                ),
                                child: Row(
                                  children: [
                                    model.isCheck!.value ? Icon(Icons.calendar_month,size: 15.h,) : 0.verticalSpace,
                                    4.horizontalSpace,
                                    AppText(
                                      index == 0
                                          ? controller.isSelected.value != (-1)
                                      ? controller.selectDateFilter[controller.isSelected.value]
                                      : model.name ?? ""
                                          :controller.isSelected2.value != (-1)
                                          ? controller.entryTypeFilter[controller.isSelected2.value]
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
                      12.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.greyText,
                              thickness: 0.7.h,
                            ),
                          ),
                          5.horizontalSpace,
                          AppText(
                            "Showing ${controller.entriesList.length} entries",
                            color: AppColors.greyText,
                            fontSize: FontSize.s14,
                            fontFamily: FontFamily.semiBold,
                          ),
                          5.horizontalSpace,
                          Expanded(
                            child: Divider(
                              color: AppColors.greyText,
                              thickness: 0.7.h,
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.entriesList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 20.h, left: 0, right: 0),
                        itemBuilder: (context, index) {
                          CommonModel data = controller.entriesList[index];
                          return Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                12.verticalSpace,
                                Padding(
                                  padding: EdgeInsets.only(left: 20.h),
                                  child: AppText(
                                    data.name ?? "",
                                    fontFamily: FontFamily.semiBold,
                                    color: AppColors.greyText,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                                15.verticalSpace,
                                ListView.builder(
                                  itemCount: data.list!.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    CommonModel model = data.list![index];
                                    return Container(
                                      color: AppColors.whiteColor,
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  color: AppColors.skyColor.withOpacity(0.15),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
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
                                                      model.price ?? "N/A",
                                                      color: AppColors.marron,
                                                      fontFamily: FontFamily.bold,
                                                      fontSize: FontSize.s18,
                                                    ),
                                                    5.verticalSpace,
                                                    AppText(
                                                      "Balance: ${model.id ?? "N/A"}",
                                                      color: AppColors.greyText,
                                                      fontFamily: FontFamily.medium,
                                                      fontSize: FontSize.s16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          8.verticalSpace,
                                          AppText(
                                            model.name ?? "",
                                            color: AppColors.darkText,
                                            fontSize: FontSize.s16,
                                            fontFamily: FontFamily.medium,
                                          ),
                                          7.verticalSpace,
                                          Divider(
                                            color: AppColors.greyColor.withOpacity(0.3),
                                            thickness: 0.7.h,
                                          ),
                                          7.verticalSpace,
                                          Row(
                                            children: [
                                              AppText(
                                                "${Strings.entryByYou} ",
                                                color: AppColors.entryTextColor,
                                                fontFamily: FontFamily.bold,
                                                fontSize: FontSize.s16,
                                              ),
                                              AppText(
                                                model.icon ?? "",
                                                color: AppColors.greyText,
                                                fontFamily: FontFamily.medium,
                                                fontSize: FontSize.s14,
                                              ),
                                            ],
                                          ),
                                          12.verticalSpace,
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
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
      },
    );
  }
}
