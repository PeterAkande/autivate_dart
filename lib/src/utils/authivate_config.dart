/// This the config class for
class AuthivateConfig {
  ///
  AuthivateConfig({required this.apiKey, required this.projectId});

  /// The Authority or Host for the Authivate service
  final String host = 'api.authivate.com';

  /// The Api to be used by the user for identification
  final String apiKey;

  /// This is the project id
  final String projectId;
}
