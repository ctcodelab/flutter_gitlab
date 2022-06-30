import 'package:dio/dio.dart';
import 'package:gitlab/gitlab.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// An abstraction for `http` that allows us to mock it.
///
/// **Never use this class directly in the library.**
/// Use `GitLab.request()` instead.
/// An instance of this class is created in the `GitLab` class, and will be used
/// only by it.
class GitLabHttpClient {
  GitLabHttpClient({bool dioLogger = false}) {
    if (dioLogger) {
      dio.interceptors.add(PrettyDioLogger());
    }
  }

  final dio = Dio();

  Future<Response> request(
    String uri, {
    required Map<String, dynamic> header,
    required HttpMethod method,
    Map<String, dynamic>? queryParameters,
  }) {
    if (method == HttpMethod.get) {
      return dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(
          headers: header,
        ),
      );
    } else if (method == HttpMethod.put) {
      return dio.put(
        uri,
        data: queryParameters,
        options: Options(
          headers: header,
        ),
      );
    } else if (method == HttpMethod.post) {
      return dio.post(
        uri,
        data: queryParameters,
        options: Options(
          headers: header,
        ),
      );
    } else if (method == HttpMethod.delete) {
      return dio.delete(
        uri,
        data: queryParameters,
        options: Options(
          headers: header,
        ),
      );
    } else {
      throw ArgumentError('Invalid http method: $method');
    }
  }
}
