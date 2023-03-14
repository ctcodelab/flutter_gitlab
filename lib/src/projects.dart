part of flutter_gitlab;

class ProjectsApi {
  ProjectsApi(this._gitLab);

  final GitLab _gitLab;

  MergeRequestsApi? _mergeRequestsApi;

  MergeRequestsApi get mergeRequests => _mergeRequestsApi ??= MergeRequestsApi(_gitLab, this);

  static const endpoint = '/projects';

  Future<Response> membershipProjects({
    Map<String, dynamic>? queryParameters,
  }) async {
    return _gitLab.request(
      endpoint,
      queryParameters: {'membership': true}..addAll(queryParameters ?? {}),
    );
  }

  Future<Response> projectMergeRequests({
    required int projectId,
    Map<String, dynamic>? queryParameters,
  }) {
    return _gitLab.request(
      '$endpoint/$projectId/merge_requests',
      queryParameters: queryParameters,
    );
  }

  Future<Response> projectMembers({
    required int projectId,
    Map<String, dynamic>? queryParameters,
  }) {
    return _gitLab.request(
      '$endpoint/$projectId/users',
      queryParameters: queryParameters,
    );
  }
}
