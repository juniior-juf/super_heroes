abstract class HttpClient {
  Future<R?> request<R>({
    required HttpMethod method,
    required String version,
    required String path,
    R Function(Map<String, dynamic> json)? fromJson,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  });
}

enum HttpMethod { get, post, put, delete, patch }
