abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required HttpMethods method,
    Map? body,
    Map? headers,
  });
}

enum HttpMethods {
  post,
  get,
  del,
}
