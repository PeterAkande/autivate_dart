import 'package:authivate/src/mixins/request_mixin.dart';
import 'package:authivate/src/utils/authivate_config.dart';
import 'package:authivate/src/utils/authivate_exceptions.dart';
import 'package:authivate/src/utils/authivate_response_type.dart';

import 'package:http/http.dart' as http;

/// {@template authivate}
/// The Dart SDK for the Authivate service
/// {@endtemplate}
class Authivate with RequestMixin {
  /// {@macro authivate}
  factory Authivate({
    required AuthivateConfig config,
  }) {
    _instance ??= Authivate._(config: config);

    return instance;
  }

  Authivate._({required this.config}) {
    _headers = {'Authorization': 'Bearer ${config.apiKey}'};
  }

  static Authivate? _instance;

  /// The configurations needed to communicate with the Authivate Service
  final AuthivateConfig config;

  /// Single client to be used for all network calls.
  ///
  /// This is here so that requests are faster
  /// (TCP Handshake -ACK, SYNACK is done only once)
  final client = http.Client();

  Map<String, String>? _headers;

  /// @nodoc
  static Authivate get instance {
    if (_instance == null) {
      throw AuthivateException('Please Initialize Authivate First');
    }

    return _instance!;
  }

  /// Signs up a user for the particular Project
  Future<AuthivateResponse> signUpUser({
    required String emailAddress,
    required String lastName,
    required String firstName,
    String password = '',
  }) async {
    const url = 'api/v1/p/user/signup/';

    final body = {
      'email_address': emailAddress,
      'project_id': config.projectId,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };

    final uri = Uri.https(config.host, url);

    final response = await postRequest(
      uri: uri,
      client: client,
      headers: _headers,
      body: body,
    );

    return response;
  }

  /// Sign in a user to the project
  Future<AuthivateResponse> signInUser({
    required String emailAddress,
    String password = '',
  }) async {
    //This function would create a user record for a project
    const url = 'api/v1/p/user/signin/';

    final body = {
      'email_address': emailAddress,
      'project_id': config.projectId,
      'password': password
    };

    final uri = Uri.https(config.host, url);

    final response = await postRequest(
      uri: uri,
      client: client,
      headers: _headers,
      body: body,
    );

    return response;
  }

  /// Makes A Request to request an OTP for the user
  Future<AuthivateResponse> requestOTPForUser({
    required String emailAddress,
  }) async {
    //This function would request OTP for the email address that is given.
    const url = 'api/v1/p/request_otp/';

    final body = {
      'email_address': emailAddress,
      'project_id': config.projectId,
    };

    final uri = Uri.https(config.host, url);

    final response = await postRequest(
        uri: uri, client: client, headers: _headers, body: body);

    return response;
  }

  /// Makes a request send a Forgot password Email to the user
  Future<AuthivateResponse> requestForgotPasswordForUser(
      {required String emailAddress}) async {
    const url = 'api/v1/p/request_password_reset/';

    final body = {
      'email_address': emailAddress,
      'project_id': config.projectId
    };

    final uri = Uri.https(config.host, url);

    final response = await postRequest(
        uri: uri, client: client, headers: _headers, body: body);

    return response;
  }

  /// Signs up a user for the particular Project
  Future<AuthivateResponse> addUserToWaitlist({
    required String emailAddress,
    required String lastName,
    required String firstName,
  }) async {
    const url = 'api/v1/p/user/signup/';

    final body = {
      'email_address': emailAddress,
      'project_id': config.projectId,
      'first_name': firstName,
      'last_name': lastName,
      'signup_status': 'WAITLISTED',
    };

    final uri = Uri.https(config.host, url);

    final response = await postRequest(
      uri: uri,
      client: client,
      headers: _headers,
      body: body,
    );

    return response;
  }
}
