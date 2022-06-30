part of exitlive.gitlab;

class MergeRequestsApi {
  final GitLab _gitLab;
  final ProjectsApi _project;

  MergeRequestsApi(this._gitLab, this._project);
}
