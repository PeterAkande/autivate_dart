import 'package:authivate/src/utils/authivate_failure.dart';
import 'package:dartz/dartz.dart';

/// The Default response Type for all service calls made to the Authivate Service
typedef AuthivateResponse = Either<AuthivateFailure, Map<String, dynamic>>;

/// @nodoc
extension AuthivateResponseX on AuthivateResponse {
  /// Returns the failure message
  String get failureMessage => fold((l) => l.message, (r) => '');

  /// Returns the response body gotten from the successful response
  Map<String, dynamic> get successResponse => fold((l) => {}, (r) => r);
}
