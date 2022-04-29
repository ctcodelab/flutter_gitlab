import 'package:gitlab/gitlab.dart';

const gitLabToken = 'glpat-KUsnhRnQJELNpUdzXiM5';
const projectId = 4174;

void main() async {
  final project = GitLab(gitLabToken, host: 'gitlab.ims.io').project(projectId);

  // List all commits that have been done in the last 24h
  final commits = await project.commits.list(
    since: DateTime.now().subtract(new Duration(days: 1)),
  );

  // print(commits.first.createdAt);
  // print(commits.first.message);

  /// The internal id of the merge request.
  final iid = 2;
  final mergeRequest = await project.mergeRequests.get(iid);

  // print(mergeRequest.title);
  print(await project.mergeRequests.list(perPage: 100));
}
