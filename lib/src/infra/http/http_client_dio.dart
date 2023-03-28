import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'http_client.dart';

class HttpClientDio extends HttpClient {
  late final Dio _client;

  HttpClientDio() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final publicKey = dotenv.env['PUBLIC_KEY'];
    final privateKey = dotenv.env['PRIVATE_KEY'];
    final hash =
        md5.convert(utf8.encode('$timestamp$privateKey$publicKey')).toString();

    _client = Dio(BaseOptions(
      baseUrl: dotenv.env['HOST_API']!,
      queryParameters: {
        'apikey': publicKey,
        'ts': timestamp,
        'hash': hash,
      },
    ));
    _client.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  bool _isSuccess(int? statusCode) {
    if (statusCode == null) return false;
    if (statusCode >= 200 && statusCode <= 299) return true;
    return false;
  }

  @override
  Future<R?> request<R>({
    required HttpMethod method,
    required String version,
    required String path,
    R Function(Map<String, dynamic> json)? fromJson,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    try {
      Response? response;

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(
            version + path,
            queryParameters: queryParams,
          );
          break;
        default:
      }

      if (_isSuccess(response?.statusCode)) {
        return fromJson?.call(response?.data);
      }
      return null;
    } catch (exception) {
      log('', error: exception);
      return null;
    }
  }
}
