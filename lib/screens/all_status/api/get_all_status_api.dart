import 'dart:developer';
import 'package:status_viewer_app/components/connectivity.dart';
import 'package:http/http.dart' as http;

class GetAllStatusApi {
  static Future<dynamic> getAllStatus() async {
    try {
      bool network = await InternetConnectivity.checking();
      if (network) {
        final response = await http.get(
          Uri.parse(
            "http://my-json-server.typicode.com/shakeebM/StoriesApi/stories",
          ),
        );
        if (response.statusCode == 200) {
          return response;
        } else {
          throw "Something went wrong";
        }
      } else {
        return "";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
