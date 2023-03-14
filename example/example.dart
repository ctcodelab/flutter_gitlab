import 'package:dio/dio.dart';
import 'package:flutter_gitlab/flutter_gitlab.dart';

/// Please refer https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token for details
const gitLabToken = 'ENTER YOUR GITLAB ACCESS TOKEN HERE';
const projectId = 0; // ENTER YOUR PROJECT ID

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
