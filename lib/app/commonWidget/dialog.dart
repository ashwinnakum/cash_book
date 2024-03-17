import 'package:cash_book/app/data/all.dart';

showConfirmDialog(
  BuildContext context,
  String title,
  String description,
  String confirmBtnTxt,
  String cancelBtnTxt,
  Function onConfirmClicked,
) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: AppText(cancelBtnTxt, color: AppColors.blackColor, fontFamily: FontFamily.medium, fontSize: 16.sp),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  Widget confirmButton = TextButton(
    child: AppText(confirmBtnTxt, color: AppColors.primary, fontFamily: FontFamily.medium, fontSize: 16.sp),
    onPressed: () {
      onConfirmClicked.call();
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.whiteColor,
    title: AppText(title, color: AppColors.darkText, fontFamily: FontFamily.semiBold, fontSize: 22.sp),
    content: AppText(description, color: AppColors.darkText, fontFamily: FontFamily.medium, fontSize: 16.sp),
    actions: [
      cancelButton,
      confirmButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
