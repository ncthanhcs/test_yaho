import 'package:test_yaho/core/services/http_client.dart';
import 'package:test_yaho/core/utils/hive_utils.dart';
import 'package:test_yaho/models/image_group_model.dart';
import 'package:test_yaho/models/image_model.dart';

class ImageRepository {
  final HttpClientApi httpClient;
  ImageRepository({
    required this.httpClient,
  });
  final path = '/api/users';
  Future<ImageGroupModel?> getListImage(int page) async {
    Map? result;
    result = HiveUtils.instance.page(page);
    result ??=
        await httpClient.get(path: path, params: {'page': page.toString()});
    try {
      final imageGroup =
          ImageGroupModel.fromJson(result.cast<String, dynamic>());
      HiveUtils.instance.savePage(page, result);
      return imageGroup;
    } catch (e) {
      print('Error $e');
    }
    return null;
  }
}
