/// This library allows you to communicate with the GitLab api.
/// It supports the default `gitlab.com` but also any other GitLab deployment you might have.
///
/// Usage:
///
///     // Setup your gitLab or gitLabProject once.
///     final gitLab  = new GitLab(secretToken);
///     final gitLabProject = gitLab.project('exit-live');
///
///     // Then use it whenever you need in your app.
///     final allMergeRequests = await gitLabProject.mergeRequests.list();
///     final allIssues = await gitLabProject.issues.list(page: 3, perPage: 30);
///     final issue = await gitLabProject.issues.get(allIssues.first.id);
///
/// For more information, please refer to the
/// [official GitLab API documentation at gitlab.com](https://docs.gitlab.com/ee/api/README.html).
library exitlive.flutter_gitlab;

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gitlab/src/http_client.dart';
import 'package:meta/meta.dart';

part 'src/merge_requests.dart';
part 'src/projects.dart';
part 'src/user.dart';

enum HttpMethod { get, post, put, delete }

/// The main class and entry point to use this library.
///
/// See the library documentation for information on how to use it.
class GitLab {
  final String token;
  final String host;
  final String scheme;

  final GitLabHttpClient _httpClient;

  static const String apiVersion = 'v4';

  GitLab(
    this.token, {
    this.host = 'gitlab.com',
    this.scheme = 'https',
    bool requestLogger = false,
  }) : _httpClient = GitLabHttpClient(dioLogger: requestLogger);

  /// Returns the dio.Response.
  @visibleForTesting
  Future<Response> request(
    String uri, {
    HttpMethod method: HttpMethod.get,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
  }) async {
    final headers = header ?? <String, dynamic>{};
    headers['PRIVATE-TOKEN'] = token;

    try {
      final response = await _httpClient.request(
        '$scheme://$host/api/$apiVersion/$uri',
        header: headers,
        method: method,
        queryParameters: queryParameters,
      );
      if (response.statusCode == null) {
        throw GitLabException(response.statusCode ?? -1, 'Response is null.');
      } else if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        throw GitLabException(response.statusCode!, 'Check the status code.');
      }

      return response;
    } on DioError catch (e) {
      throw GitLabException(-1, e.message);
    }
  }

  /// Get the [ProjectsApi] for this [id].
  ///
  /// This call doesn't do anything by itself, other than return the configured object.
  /// You can safely store the returned object and reuse it.
  ProjectsApi get project => ProjectsApi(this);

  UserApi get user => UserApi(this);
}

class GitLabException implements Exception {
  final int statusCode;
  final String message;

  GitLabException(this.statusCode, this.message);

  @override
  String toString() => 'GitLabException ($statusCode): $message';
}
