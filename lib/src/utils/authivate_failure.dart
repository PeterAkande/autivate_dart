import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Response;

/// This is the Data class for All failures that happens when making calls to the
/// authivate API
class AuthivateFailure {
  /// The constructor
  AuthivateFailure({
    required this.statusCode,
    required this.responseBody,
    this.message = '',
  }) {
    assert(responseBody != null, 'Response Body cannot be null!');
  }

  /// Consstructs an AuthivateFailire from an Exception
  factory AuthivateFailure.fromException(Object? exception) {
    if (exception is SocketException) {
      final failure = AuthivateFailure(
          statusCode: 0, responseBody: {}, message: 'Error in Connection');

      return failure;
    }

    final failure = AuthivateFailure(
        statusCode: 0, responseBody: {}, message: 'Unknown Error Occurred');

    return failure;
  }

  /// Constructs a Failure from the failed reponse, a typical 4** error
  factory AuthivateFailure.fromFailedResponse(Response resp) {
    String error = '';

    final decodedResponse = jsonDecode(resp.body) as Map<String, dynamic>;

    if (decodedResponse.containsKey('message')) {
      error = decodedResponse['message'] as String;
    } else if (decodedResponse.containsKey('error')) {
      error = decodedResponse['error'] as String;
    } else if (decodedResponse.containsKey('detail')) {
      error = decodedResponse['detail'] as String;
    } else {
      error = 'An error occurred';
    }

    final failure = AuthivateFailure(
        statusCode: resp.statusCode, responseBody: resp.body, message: error);
    return failure;
  }

  /// The status code of the response, would be 0 if an exception occurrs
  int statusCode;

  /// The response body for all calls to the Authivate Service
  dynamic responseBody;

  /// A message telling the reason for the error, if it is(Can be empty)
  String message;
}
