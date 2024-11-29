import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cash_book/app/data/all.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../commonWidget/common_bottom_sheet.dart';
import '../../../models/book_detail_model.dart';

class AddDetailController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController remark = TextEditingController();
  String withScreen = Strings.add;
  FocusNode amountNode = FocusNode();
  DateTime datePicker = DateTime.now();
  TimeOfDay timerPicker = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  RxString imageFile = "".obs;
  List<CommonModel> fileList = [];
  List<int> removeList = [];
  String isPlus = Strings.inKey;
  int bookId = 0;
  BookHistories? bookHistories;
  RxBool isAmountAvailable = false.obs;
  int cnt = 0;
  RxBool isNew = false.obs;

  @override
  Future<void> onInit() async {
    printAction('----------------->>>>>>this is focus${DateTime.now()}');
    if (Get.arguments != null) {
      withScreen = Get.arguments[Strings.withScreen];
      isPlus = Get.arguments[Strings.isPlus];
      bookId = Get.arguments['bookId'] ?? 0;
      bookHistories = Get.arguments['bookingModel'];
    }
    if (bookHistories != null) {
      isAmountAvailable.value = true;
      bookId = bookHistories!.bookId!;
      dataFill();
    }
    await Future.delayed(Duration(milliseconds: 100));
    FocusScope.of(Get.context!).requestFocus(amountNode);
    super.onInit();
  }

  dataFill() {
    amountController.text = bookHistories!.amount!.abs().toString();
    remark.text = bookHistories!.remark!;
    datePicker = DateTime.parse('${bookHistories!.entryDate} ${bookHistories!.entryTime}');
    timerPicker = TimeOfDay(
        hour: DateTime.parse('${bookHistories!.entryDate} ${bookHistories!.entryTime}').hour,
        minute: DateTime.parse('${bookHistories!.entryDate} ${bookHistories!.entryTime}').minute);
    for (int i = 0; i < bookHistories!.attaches!.length; i++) {
      fileList.add(
        CommonModel(
          name: bookHistories!.attaches![i].name,
          id: bookHistories!.attaches![i].mediaId,
          isNetwork: true.obs,
          type: bookHistories!.attaches![i].name?.split('.').last == 'pdf' ? Strings.isPdf : Strings.isGallery,
        ),
      );
    }
    printAction('fileList----------------->>>>>>${fileList.length}');
    update();
  }

  validation() {
    if (Utils().isValidationEmpty(amountController.text.trim())) {
      Utils().showToast(message: 'Please enter amount', context: Get.context!);
    } else {
      if (withScreen == Strings.edit) {
        editCashEntryApi();
      } else {
        addCashEntryApi();
      }
    }
  }

  addCashEntryApi() async {
    FormData formData = FormData.fromMap({
      'book_id': bookId,
      'cash_type': isPlus,
      'amount': amountController.text.trim(),
      'entry_date': Utils().changeDateFormat(date: datePicker, outputFormat: 'yyyy-MM-dd'),
      'entry_time': '${timerPicker.hour}:${timerPicker.minute}:${DateTime.now().second}',
      'remark': remark.text.trim(),
      'user_id': await GetStorageData().readString(GetStorageData().userId),
    });
    for (int i = 0; i < fileList.length; i++) {
      formData.files.addAll([MapEntry("file[]", await MultipartFile.fromFile(fileList[i].name!, filename: fileList[i].name!.split('/').last))]);
    }
    var data = await APIFunction().apiCall(apiName: Constants.addCashEntry, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      if (isNew.value) {
        amountController.text = '';
        remark.text = '';
        fileList = [];
        cnt++;
        update();
      } else {
        Get.back(result: true);
      }

      Utils().showToast(
          message: '${Strings.newEntryAddedToast} ${Utils().changeDateFormat(date: datePicker, outputFormat: 'dd MMM, yyy')}', context: Get.context!);
    } else {
      Utils().showToast(
          message: '${Strings.newEntryAddedToast} ${Utils().changeDateFormat(date: datePicker, outputFormat: 'dd MMM, yyy')}', context: Get.context!);
    }
  }

  editCashEntryApi() async {
    FormData formData = FormData.fromMap({
      'book_id': bookId,
      'bh_id': bookHistories!.bhId!,
      'cash_type': isPlus,
      'amount': amountController.text.trim(),
      'entry_date': Utils().changeDateFormat(date: datePicker, outputFormat: 'yyyy-MM-dd'),
      'entry_time': '${timerPicker.hour}:${timerPicker.minute}:${DateTime.now().second}',
      'remark': remark.text.trim(),
      if (removeList.isNotEmpty) 'remove_media_ids': removeList.join(','),
      'user_id': await GetStorageData().readString(GetStorageData().userId),
    });
    for (int i = 0; i < fileList.length; i++) {
      if (!fileList[i].isNetwork!.value) {
        formData.files.addAll([MapEntry("file[]", await MultipartFile.fromFile(fileList[i].name!, filename: fileList[i].name!.split('/').last))]);
      }
    }

    var data = await APIFunction().apiCall(apiName: Constants.updateCashEntry, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      if (isNew.value) {
        amountController.text = '';
        remark.text = '';
        fileList = [];
        cnt++;
        withScreen = Strings.add;
        update();
      } else {
        Get.back(result: true);
      }
      Utils().showToast(
          message: '${Strings.newEntryAddedToast} ${Utils().changeDateFormat(date: datePicker, outputFormat: 'dd MMM, yyy')}', context: Get.context!);
    } else {}
  }

  deleteCashEntryApi() async {
    FormData formData = FormData.fromMap({
      'bh_id': bookHistories!.bhId!,
      'user_id': await GetStorageData().readString(GetStorageData().userId),
    });
    var data = await APIFunction().apiCall(apiName: Constants.deleteCashEntry, context: Get.context!, params: formData);

    if (data['ResponseCode'] == 1) {
      Get.back();
      Get.back(result: true);
      Utils().showToast(message: data['ResponseMsg'], context: Get.context!);
    } else {}
  }

  pickerSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CommonBottomSheet(
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.close, size: 26.h)),
                        25.horizontalSpace,
                        AppText(
                          Strings.attachImageOrPdf,
                          fontSize: 18.sp,
                          color: AppColors.blackColor,
                          fontFamily: FontFamily.semiBold,
                        )
                      ],
                    ),
                  ),
                  15.verticalSpace,
                  Container(height: 1.h, color: AppColors.greyText.withOpacity(0.2), width: double.infinity),
                  12.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            getFromGallery(isGallery: false);
                            Get.back();
                          },
                          child: Container(
                            height: 58.h,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt_outlined, size: 26.h, color: AppColors.primary),
                                20.horizontalSpace,
                                AppText(
                                  Strings.takePhotoUsingCamera,
                                  fontSize: 18.sp,
                                  color: AppColors.blackColor.withOpacity(0.7),
                                  fontFamily: FontFamily.medium,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 46.h),
                          child: Container(height: 1.h, color: AppColors.greyText.withOpacity(0.1), width: double.infinity),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            getFromGallery(isGallery: true);
                            Get.back();
                          },
                          child: Container(
                            height: 58.h,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Icon(Icons.image_outlined, size: 26.h, color: AppColors.primary),
                                20.horizontalSpace,
                                AppText(
                                  Strings.chooseFromGallery,
                                  fontSize: 18.sp,
                                  color: AppColors.blackColor.withOpacity(0.7),
                                  fontFamily: FontFamily.medium,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 46.h),
                          child: Container(height: 1.h, color: AppColors.greyText.withOpacity(0.1), width: double.infinity),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: FontSize.defaultPadding),
                    child: GestureDetector(
                      onTap: () {
                        filePick();
                        Get.back();
                      },
                      child: Container(
                        height: 58.h,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Icon(Icons.picture_as_pdf_outlined, size: 26.h, color: AppColors.primary),
                            20.horizontalSpace,
                            AppText(
                              Strings.choosePdf,
                              fontSize: 18.sp,
                              color: AppColors.blackColor.withOpacity(0.7),
                              fontFamily: FontFamily.medium,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  getFromGallery({bool isGallery = false}) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: isGallery ? ImageSource.gallery : ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = (pickedFile.path.obs);
      fileList.add(
        CommonModel(
          name: imageFile.value,
          type: Strings.isGallery,
          id: 0,
          isNetwork: false.obs,
        ),
      );
      update();
    }
    update();
  }

  filePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      fileList.add(CommonModel(
        name: result.files.first.path,
        type: Strings.isPdf,
        id: 0,
        isNetwork: false.obs,
      ));
      update();
    }
  }

  showMyDatePicker() async {
    datePicker = (await showDatePicker(
      context: Get.context!,
      initialDate: datePicker,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    ))!;
    print(DateFormat("yyyy-MM-dd").format(datePicker));
    update();
  }

  showMyTimePicker(BuildContext context) async {
    timerPicker = (await showTimePicker(
      context: context,
      initialTime: timerPicker,
    ))!;

    update();
  }

  imageShowDialog(int index, bool isNetwork) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(vertical: 100.h, horizontal: FontSize.defaultPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.r),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: isNetwork
                ? CachedNetworkImage(
                    imageUrl: fileList[index].name!,
                    fit: BoxFit.fill,
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
                  )
                : Image.file(
                    File(fileList[index].name!),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
      ),
    );
  }
}
