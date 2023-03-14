part of flutter_gitlab;

class UserApi {
  UserApi(this._gitLab);

  final GitLab _gitLab;

  static const endpoint = '/user';

  Future<Response> get() {
    return _gitLab.request(endpoint);
  }
}
