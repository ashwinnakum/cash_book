import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../commonWidget/dialog.dart';
import '../../../data/all.dart';
import '../controllers/add_detail_controller.dart';

class AddDetailView extends GetView<AddDetailController> {
  const AddDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDetailController>(builder: (logic) {
      return CommonScreen(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: true,
        child: Column(
          children: [
            Expanded(
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
                              Get.back(result: controller.cnt != 0);
                            },
                            child: const Icon(Icons.arrow_back, color: AppColors.whiteColor)),
                        18.horizontalSpace,
                        AppText(
                          '${controller.withScreen} cash ${controller.isPlus} entry',
                          color: controller.isPlus == Strings.inKey ? AppColors.whiteColor : Colors.red,
                          fontSize: FontSize.s18,
                          fontFamily: FontFamily.semiBold,
                        ),
                        Spacer(),
                        controller.withScreen == Strings.edit
                            ? GestureDetector(
                                onTap: () {
                                  showConfirmDialog(Get.context!, Strings.deleteEntry, Strings.doYouWantDeleteEntry, Strings.delete, Strings.cancel,
                                      () {
                                    controller.deleteCashEntryApi();
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 30.h,
                                  width: 30.h,
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColors.redButtonColor,
                                  ),
                                ),
                              )
                            : SizedBox(height: 30.h, width: 30.h),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding, vertical: 24.h),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Utils().hideKeyboard();

                                controller.showMyDatePicker();
                              },
                              child: Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: Colors.deepPurple,
                                    onPrimary: Colors.white,
                                    surface: Colors.pink,
                                    onSurface: Colors.yellow,
                                  ),
                                  dialogBackgroundColor: Colors.blue[900],
                                ),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: AppColors.greyText,
                                        size: 22.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w, right: 4.w),
                                        child: AppText(
                                          Utils().changeDateFormat(date: controller.datePicker, outputFormat: 'dd/MM/yyy'),
                                          color: AppColors.blackColor,
                                          fontFamily: FontFamily.semiBold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down, color: AppColors.greyText)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Utils().hideKeyboard();

                                controller.showMyTimePicker(context);
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_sharp,
                                      color: AppColors.greyText,
                                      size: 22.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.w, right: 4.w),
                                      child: AppText(
                                        TimeOfDay(hour: controller.timerPicker.hour, minute: controller.timerPicker.minute).format(context),
                                        color: AppColors.blackColor,
                                        fontFamily: FontFamily.semiBold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down, color: AppColors.greyText)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        24.verticalSpace,
                        CommonAppTextField(
                          controller: controller.amountController,
                          hintText: Strings.amount,
                          labelText: Strings.amount,
                          focusNode: controller.amountNode,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) {
                            controller.isAmountAvailable.value = true;
                            controller.update();
                          },
                        ),
                        Visibility(
                          visible: controller.isAmountAvailable.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.verticalSpace,
                              CommonAppTextField(
                                controller: controller.remark,
                                hintText: Strings.remarkItemPerson,
                                labelText: Strings.remark,
                              ),
                              20.verticalSpace,
                              Visibility(
                                visible: controller.fileList.isEmpty,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.pickerSheet();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                              border: Border.all(color: Colors.grey.withOpacity(0.6), width: 1.h)),
                                          padding: EdgeInsets.only(left: 16.w, right: 19.w, top: 8.h, bottom: 8.h),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                ImagePath.imagesIcNewAttach,
                                                height: 21.h,
                                                width: 21.h,
                                                color: AppColors.primary,
                                              ),
                                              10.horizontalSpace,
                                              AppText(Strings.attachImageOrPdf,
                                                  fontSize: 14.sp, fontFamily: FontFamily.semiBold, color: AppColors.primary)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 80.h,
                                child: ListView.builder(
                                  itemCount: controller.fileList.length + (controller.fileList.isNotEmpty ? 1 : 0),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (index == controller.fileList.length) {
                                              controller.pickerSheet();
                                            }
                                          },
                                          child: Container(
                                            height: 60.h,
                                            width: 60.h,
                                            child: index == controller.fileList.length
                                                ? Icon(
                                                    Icons.add,
                                                    size: 35.h,
                                                    color: AppColors.primary,
                                                  )
                                                : controller.fileList[index].type == Strings.isPdf
                                                    ? Padding(
                                                        padding: EdgeInsets.all(13.h),
                                                        child: Image.asset(
                                                          ImagePath.imagesIcBluePdf,
                                                          height: 40.h,
                                                          width: 40.h,
                                                        ),
                                                      )
                                                    : !controller.fileList[index].isNetwork!.value
                                                        ? ClipRRect(
                                                            borderRadius: BorderRadius.circular(5.r),
                                                            child: Image.file(
                                                              File(controller.fileList[index].name!),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius: BorderRadius.circular(5.r),
                                                            child: CachedNetworkImage(
                                                              imageUrl: controller.fileList[index].name!,
                                                              fit: BoxFit.cover,
                                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                                              progressIndicatorBuilder: (context, url, progress) {
                                                                return Shimmer.fromColors(
                                                                  baseColor: Colors.grey.withOpacity(0.2),
                                                                  highlightColor: Colors.white.withOpacity(0.2),
                                                                  enabled: true,
                                                                  child: Container(
                                                                    color: Colors.grey,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: index == controller.fileList.length ? AppColors.primary : AppColors.greyText, width: 0.5.h),
                                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                            ),
                                            margin: EdgeInsets.only(right: 30.w, top: 10.h),
                                          ),
                                        ),
                                        Visibility(
                                          visible: index != controller.fileList.length,
                                          child: Positioned(
                                            right: 20.w,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (controller.fileList[index].id != 0) {
                                                  controller.removeList.add(controller.fileList[index].id!);
                                                }
                                                controller.fileList.removeAt(index);
                                                controller.update();
                                              },
                                              child: Container(
                                                height: 22.h,
                                                width: 22.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red.withOpacity(0.7),
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 16.h,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(height: 1.h, color: Colors.grey.withOpacity(0.3), width: double.infinity),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(
                      left: FontSize.defaultPadding, right: FontSize.defaultPadding, bottom: MediaQuery.of(context).padding.bottom + 5.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CommonButton(
                          onTap: () {
                            controller.isNew.value = true;
                            controller.update();
                            controller.validation();
                          },
                          text: Strings.saveAddNew,
                          padding: EdgeInsets.symmetric(vertical: 17.h),
                          borderRadius: 6.r,
                          color: AppColors.transparentColor,
                          borderColor: AppColors.primary,
                          textColor: AppColors.primary,
                          border: Border.all(width: 1, color: AppColors.primary),
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        flex: 2,
                        child: CommonButton(
                          onTap: () {
                            controller.isNew.value = false;
                            controller.update();
                            controller.validation();
                          },
                          text: Strings.save,
                          padding: EdgeInsets.symmetric(vertical: 17.h),
                          borderRadius: 6.r,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
