import 'package:dio/dio.dart';
import 'package:gitlab/gitlab.dart';

const gitLabToken = 'glpat-KUsnhRnQJELNpUdzXiM5';
const projectId = 4174;

void main() async {
  final project = GitLab(
    gitLabToken,
    host: 'gitlab.ims.io',
    scheme: 'https',
    requestLogger: true,
  ).project;
  try {
    await project.membershipProjects();
  } on DioError catch (e) {
    print(e);
  }
}
