import 'package:cash_book/app/data/all.dart';

RxBool isFirst = true.obs;

class Constants {
  static const String apiKey = 'jExwb7PralnoOTGSd42SDFSgO0xczgrGedQvpLwo4W';
  static const emailRegX = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const nameRegX = r'^(?=.*[a-zA-Z])[\s\S]{2,}$';
  static const phoneRegX = r'^\+?(\d{1,4})?\s?[-.\s]?(\d+[-.\s]?){6,}$';
  static const dateRegX = r'^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/(19|20)\d\d$';

  static const String YYYY_MM_DD_HH_MM_SS = 'yyyy-MM-dd hh:mm:ss';
  static const String YYYY_MM_DD_HH_MM_SS_24 = 'yyyy-MM-dd HH:mm:ss';

//todo ------ base url ---------//
  static const String baseUrl = 'https://ds-staging.000webhostapp.com/money_book/api/';
  static String versionName = '';

//todo ------ api collection ---------//
  static const String login = 'login';
  static const String home = 'home';
  static const String addUpdateBook = 'addUpdateBook';
  static const String deleteBook = 'deleteBook';
  static const String getBooks = 'getBooks';
  static const String getBookDetails = 'getBookDetails';
  static const String addCashEntry = 'addCashEntry';
  static const String deleteCashEntry = 'deleteCashEntry';
}
