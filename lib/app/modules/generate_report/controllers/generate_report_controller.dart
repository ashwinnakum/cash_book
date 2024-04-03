import 'dart:io';

import 'package:cash_book/app/data/all.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class GenerateReportController extends GetxController {
  var select;
  List<CommonModel> reportList = [
    CommonModel(name: Strings.allEntriesRepost, type: Strings.listOffAllEntries),
    CommonModel(name: Strings.todayReport, type: Strings.todayInOutBalance),
    CommonModel(name: Strings.lastMonth, type: Strings.lastMonthInOutBalance),
    CommonModel(name: Strings.lastYear, type: Strings.lastYearInOutBalance),
    CommonModel(name: Strings.customDate, type: Strings.customInOutBalance),
  ];

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  RxBool isCustom = false.obs;
  RxInt isValue = 0.obs;
  RxBool isPDf = true.obs;

  late String localPath;
  late bool permissionReady;
  late TargetPlatform? platform;

  @override
  void onInit() {
    if (Get.arguments != null) {
      isValue.value = Get.arguments ?? 0;
    }
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    super.onInit();
  }

  validation() {
    if (select == null) {
      Utils().showToast(message: 'Please select report type', context: Get.context!);
    } else {
      printAction('select----------------->>>>>>${select}');
      getReportFileApi();
    }
  }

  getReportFileApi() async {
    String startDate = '';
    String endDate = '';
    if (select != null) {
      if (select == 0) {
        startDate = '';
        endDate = '';
      } else if (select != 4) {
        endDate = Utils().changeDateFormat(date: DateTime.now(), outputFormat: 'yyyy-MM-dd');
        startDate = Utils().changeDateFormat(
            date: select == 1
                ? DateTime.now()
                : select == 2
                    ? Jiffy.now().subtract(months: 1).dateTime
                    : Jiffy.now().subtract(years: 1).dateTime,
            outputFormat: 'yyyy-MM-dd');
      } else if (select == 4) {
        printAction('selectedStartDate----------------->>>>>>${selectedStartDate}');
        startDate = Utils().changeDateFormat(date: selectedStartDate, outputFormat: 'yyyy-MM-dd');
        endDate = Utils().changeDateFormat(date: selectedEndDate, outputFormat: 'yyyy-MM-dd');
      }
    }

    FormData formData = FormData.fromMap({
      if (isValue.value != 0) 'book_id': isValue.value,
      if (select != null && startDate.isNotEmpty) 'start_date': startDate,
      if (select != null && endDate.isNotEmpty) 'end_date': endDate,
    });
    final first =
        await APIFunction().apiCall(apiName: isPDf.value ? Constants.getReportPDF : Constants.getReportFile, context: Get.context!, params: formData);
    var data = await jsonDecode(first);
    if (data['ResponseCode'] == 1) {
      _launchUrl(data['data']['url']);
    } else {
      Utils().showToast(message: data['ResponseMsg'], context: Get.context!);
    }
    update();
  }

  Future<void> _launchUrl(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch');
    }
  }

  Future<bool> checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        printAction('storage is grated----------------->>>>>>${status}');
        final result = await Permission.storage.request();
        printAction('storage is result----------------->>>>>>${result}');
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> prepareSaveDir() async {
    localPath = (await _findLocalPath())!;

    print('asasas----${localPath}');
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    print('asasas is exist----${hasExisted}');

    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      var directory = await getApplicationDocumentsDirectory();
      return "${directory.path}/ashwin";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

  datePickerDialog() {
    Get.dialog(
      Dialog(
        child: GetBuilder<GenerateReportController>(
          builder: (controller) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 15.h, right: 15.h, bottom: 10.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.close),
                        ),
                        10.horizontalSpace,
                        AppText(
                          "Custom Date",
                          color: AppColors.darkText,
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s17,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.greyColor.withOpacity(0.2),
                    thickness: 1.h,
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        selectStartDate(Get.context!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppText(
                              "Start Date",
                              color: AppColors.darkText,
                              fontSize: FontSize.s18,
                              fontFamily: FontFamily.semiBold,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_rounded,
                            color: AppColors.primary,
                          ),
                          5.horizontalSpace,
                          AppText(
                            DateFormat('dd/MM/yyyy').format(selectedStartDate).toString(),
                            color: AppColors.primary,
                            fontSize: FontSize.s16,
                            fontFamily: FontFamily.medium,
                          ),
                          10.horizontalSpace,
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        selectEndDate(Get.context!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppText(
                              "End Date",
                              color: AppColors.darkText,
                              fontSize: FontSize.s18,
                              fontFamily: FontFamily.semiBold,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_rounded,
                            color: AppColors.primary,
                          ),
                          5.horizontalSpace,
                          AppText(
                            DateFormat('dd/MM/yyyy').format(selectedEndDate).toString(),
                            color: AppColors.primary,
                            fontSize: FontSize.s16,
                            fontFamily: FontFamily.medium,
                          ),
                          10.horizontalSpace,
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: CommonButton(
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        onTap: () {
                          isCustom.value = true;
                          update();
                          Get.back();
                        },
                        text: "DONE"),
                  ),
                  15.verticalSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedStartDate, firstDate: DateTime(2000, 8), lastDate: DateTime.now());
    if (picked != null && picked != selectedStartDate) {
      print("picked -- $picked");
      selectedStartDate = picked;
      update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedEndDate, firstDate: selectedStartDate, lastDate: DateTime.now());
    if (picked != null && picked != selectedEndDate) {
      print("picked -- $picked");
      selectedEndDate = picked;
      update();
    }
  }
}
