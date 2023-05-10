import 'dart:convert';
import 'dart:io';

class HttpClientApi {
  final String host;
  HttpClientApi({
    required this.host,
  });

  Future<Map> get(
      {required String path,
      int? port,
      Map<String, dynamic>? params,
      Map? headers}) async {
    HttpClientRequest request;
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 30);
    if (host.startsWith('http')) {
      var uriPattern = host;
      if (path.isNotEmpty) {
        uriPattern += path.startsWith('/') ? path : '/$path';
      }
      var uri = Uri.parse(uriPattern);
      if (params is Map<String, dynamic>) {
        uri = uri.replace(queryParameters: params);
      }
      request = await client.getUrl(uri);
    } else if (port == null) {
      throw IOException;
    } else {
      request = await client.get(host, port, path);
    }
    request.headers.contentType = ContentType("application", "json");
    headers?.forEach((name, value) => request.headers.add(name, value));
    var result = await sendApi(request);
    return result;
  }

  Future<Map> post(
      {required String path, int? port, Map? body, Map? headers}) async {
    HttpClientRequest request;
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 30);
    if (host.startsWith('http')) {
      var uriPattern = host;
      if (path.isNotEmpty) {
        uriPattern += path.startsWith('/') ? path : '/$path';
      }
      request = await client.postUrl(Uri.parse(uriPattern));
    } else if (port == null) {
      throw IOException;
    } else {
      request = await client.post(host, port, path);
    }
    request.headers.contentType = ContentType("application", "json");
    headers?.forEach((name, value) => request.headers.add(name, value));
    request.write(jsonEncode(body));
    var result = await sendApi(request);
    return result;
  }

  Future<Map> sendApi(HttpClientRequest request) async {
    var response = await request.close();
    var responseBody = '';
    await for (var data in response.transform(utf8.decoder)) {
      responseBody += data;
    }
    Map result = jsonDecode(responseBody);
    return result;
  }
}
