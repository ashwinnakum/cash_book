class Constants {
  static const String apiKey = '2b223e5cee713615ha54ac203b24e9a123703mk411';
  static const emailRegX = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const nameRegX = r'^(?=.*[a-zA-Z])[\s\S]{2,}$';
  static const phoneRegX = r'^\+?(\d{1,4})?\s?[-.\s]?(\d+[-.\s]?){6,}$';
  static const dateRegX = r'^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/(19|20)\d\d$';

//todo ------ base url ---------//
  static const String baseUrl = 'https://www.jetnexa.com/wp-json/jetnexa/v1/';
  static String versionName = '';

//todo ------ api collection ---------//
  static const String register = 'register';
  static const String login = 'login';
  static const String forgotPassword = 'forgot-password';
  static const String resetPassword = 'reset-password';
  static const String userProfile = 'user-profile';
  static const String userUpdate = 'user-update';
  static const String forgotPasswordTokenVerification = 'forgot-password-token-verification';
}
