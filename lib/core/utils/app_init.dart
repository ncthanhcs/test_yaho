
import 'package:test_yaho/core/services/http_client.dart';
import 'package:test_yaho/core/utils/hive_utils.dart';

class AppInit {
  static final AppInit instance = AppInit._internal();
  factory AppInit() {
    return instance;
  }
  AppInit._internal();
  late HttpClientApi httpClient;
  init() async {
    httpClient = HttpClientApi(host: "https://reqres.in");
    await HiveUtils.initHive();
  }
}
