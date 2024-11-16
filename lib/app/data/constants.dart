class Constants {
  static const String apiKey = 'jExwb7PralnoOTGSd42SDFSgO0xczgrGedQvpLwo4W';
  static const emailRegX = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const nameRegX = r'^(?=.*[a-zA-Z])[\s\S]{2,}$';
  static const phoneRegX = r'^\+?(\d{1,4})?\s?[-.\s]?(\d+[-.\s]?){6,}$';
  static const dateRegX = r'^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/(19|20)\d\d$';

  static const String YYYY_MM_DD_HH_MM_SS = 'yyyy-MM-dd hh:mm:ss';
  static const String YYYY_MM_DD_HH_MM_SS_24 = 'yyyy-MM-dd HH:mm:ss';

//todo ------ base url ---------//
//   static const String baseUrl = 'https://ds-staging.000webhostapp.com/money_book/api/';
//   static const String baseUrl = 'https://cashbookapp.flomiz.com/';
//   static const String baseUrl = 'http://205.209.108.170:90/money_book/api/';
  static const String baseUrl = 'https://59df-2406-b400-d11-c6bd-28e2-5ca2-888c-8466.ngrok-free.app/api/';
  static String versionName = '';

//todo ------ api collection ---------//
  static const String login = 'login';
  static const String home = 'home';
  static const String addUpdateBook = 'addUpdateBook';
  static const String deleteBook = 'deleteBook';

  // static const String ¸¸¸ = 'getBooks';
  static const String getBookDetails = 'getBookDetails';
  static const String addCashEntry = 'addCashEntry';
  static const String updateCashEntry = 'updateCashEntry';
  static const String deleteCashEntry = 'deleteCashEntry';
  static const String getReportFile = 'getReportFile';
  static const String getReportPDF = 'getReportPDF';
  static const String forgotPassword = 'forgotPassword';
  static const String updatePassword = 'updatePassword';
  static const String signUp = 'signUp';
}
