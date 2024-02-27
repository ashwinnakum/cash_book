import '../data/all.dart';
import 'api_class.dart';

/// <<< To Check Internet Availability ------------------- >>>
// ConnectivityResult? connectivityResult;
// final Connectivity connectivity = Connectivity();

class APIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    String? token = "",
    bool isLoading = true,
  }) async {
    Utils().hideKeyboard();
    printAction("params -------->>> ${params!.fields}");
    // if (true /*await getConnectivityResult()*/) {
    var response = await HttpUtil(token!, isLoading, context).post(
      apiName,
      data: params,
    );
    return response;
    // } else {
    //   return false;
    // }
  }
}

class GetAPIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    String? token = "",
    bool isLoading = true,
  }) async {
    var response = await HttpUtil(token!, isLoading, context).get(
      apiName,
    );
    return response;
  }
}

/*
Future<bool> getConnectivityResult() async {
  try {
    connectivityResult = await connectivity.checkConnectivity();
    printOkStatus(connectivityResult.toString());
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      Utils().showSnackBar(message: Strings.noInternetAvailable, context: Get.context!);
      return false;
    }
  } on PlatformException catch (e) {
    printError('e is exception --${e.toString()}');
    Utils().showSnackBar(message: Strings.noInternetAvailable, context: Get.context!);
    return false;
  }
}*/
