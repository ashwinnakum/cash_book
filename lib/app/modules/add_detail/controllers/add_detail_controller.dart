import 'package:cash_book/app/data/all.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../commonWidget/common_bottom_sheet.dart';

class AddDetailController extends GetxController {
  TextEditingController amount = TextEditingController();
  TextEditingController remark = TextEditingController();
  String withScreen = Strings.cashIn;
  FocusNode amountNode = FocusNode();
  DateTime datePicker = DateTime.now();
  TimeOfDay timerPicker = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  RxString imageFile = "".obs;
  List<CommonModel> fileList = [];
  String editScreen = Strings.add;

  @override
  Future<void> onInit() async {
    printAction('----------------->>>>>>this is focus');
    if (Get.arguments != null) {
      withScreen = Get.arguments[Strings.isPlus];
      editScreen = Get.arguments[Strings.withScreen];
    }
    await Future.delayed(Duration(milliseconds: 100));
    FocusScope.of(Get.context!).requestFocus(amountNode);
    super.onInit();
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
      fileList.add(CommonModel(name: imageFile.value, id: Strings.isGallery));
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
      fileList.add(CommonModel(name: result.files.first.path, id: Strings.isPdf));
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
  }

  showMyTimePicker(BuildContext context) async {
    timerPicker = (await showTimePicker(
      context: context,
      initialTime: timerPicker,
    ))!;
  }
}
