import 'dart:convert';
import 'dart:developer';
import 'package:authivate/src/utils/authivate_failure.dart';
import 'package:authivate/src/utils/authivate_response_type.dart';
import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

/// @nodoc
mixin RequestMixin {
  /// Makes a Post Request
  Future<AuthivateResponse> postRequest({
    required Uri uri,
    required http.Client client,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    //This function would make a post request
    try {
      final resp = await client.post(uri, headers: headers, body: body);

      log(resp.body, name: 'Authivate');
      log(resp.statusCode.toString(), name: 'Authivate');

      if (resp.statusCode.toString().startsWith('20')) {
        final res = jsonDecode(resp.body);

        return Right(res as Map<String, dynamic>);
      } else {
        return Left(AuthivateFailure.fromFailedResponse(resp));
      }
    } catch (exception) {
      log('$exception occurred', name: 'Authivate');
      return Left(AuthivateFailure.fromException(exception));
    }
  }

  /// Creates A get Request
  Future<AuthivateResponse> getRequest({
    required Uri uri,
    required http.Client client,
    Map<String, String>? headers,
  }) async {
    try {
      final resp = await client.get(uri, headers: headers);

      log(resp.body, name: 'Authivate');
      log(resp.statusCode.toString(), name: 'Authivate');

      if (resp.statusCode.toString().startsWith('20')) {
        //The response was gotten successfully
        final body = jsonDecode(resp.body) as Map<String, dynamic>;

        return Right(body);
      } else {
        return Left(AuthivateFailure.fromFailedResponse(resp));
      }
    } catch (exception) {
      log('$exception occurred', name: 'Authivate');
      return Left(AuthivateFailure.fromException(exception));
    }
  }

  /// Creates a PUT request
  Future<AuthivateResponse> putRequest({
    required Uri uri,
    required http.Client client,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final resp = await client.put(uri, body: body, headers: headers);

      log(resp.body, name: 'Authivate');
      log(resp.statusCode.toString(), name: 'Authivate');

      if (resp.statusCode.toString().startsWith('20')) {
        late Map<String, dynamic> res;
        if (resp.body.runtimeType == String) {
          res = {};
        } else {
          res = jsonDecode(resp.body) as Map<String, dynamic>;
        }

        return Right(res);
      } else {
        return Left(AuthivateFailure.fromFailedResponse(resp));
      }
    } catch (exception) {
      log('$exception occurred', name: 'Authivate');
      return Left(AuthivateFailure.fromException(exception));
    }
  }

  /// Creates a DELETE request
  Future<AuthivateResponse> deleteRequest({
    required Uri uri,
    required http.Client client,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    //This function would make a post request
    try {
      final resp = await client.delete(uri, headers: headers, body: body);

      log(resp.body, name: 'Authivate');
      log(resp.statusCode.toString(), name: 'Authivate');

      if (resp.statusCode.toString().startsWith('20')) {
        late Map<String, dynamic> res;
        if (resp.body.isEmpty) {
          res = {};
        } else {
          res = jsonDecode(resp.body) as Map<String, dynamic>;
        }

        return Right(res);
      } else {
        return Left(AuthivateFailure.fromFailedResponse(resp));
      }
    } catch (exception) {
      log('$exception occurred', name: 'Authivate');
      return Left(AuthivateFailure.fromException(exception));
    }
  }
}
