import 'dart:developer';

import 'package:authivate/authivate.dart';

void main() async {
  // initialize config
  final config = AuthivateConfig(
    apiKey: 'your-API-key-gotten-from-the-dashboard',
    projectId: 'authivate-test',
  );

  /// Initialize The Authivate Instance
  final autivateInstance = Authivate(config: config);

  /// Sign up a user
  await signUpUser();

  /// Sign In  a user
  await signInUser();

  /// Send a Confirm password email if the original one has expired
  await sendConfirmAccountEmail();

  /// Send a Forgot password email
  await sendForgotPasswordEmail();
}

Future<void> signUpUser() async {
  /// Sign Up a user
  const emailAddress = 'akandepeter@gmail.com';
  const firstName = 'Peter';
  const lastName = 'Akande';
  const password = 'Password'; // Optional, Depending on Project Settings

  final signUpResponse = await Authivate.instance.signUpUser(
    emailAddress: emailAddress,
    lastName: lastName,
    firstName: firstName,
    password: password,
  );

  if (signUpResponse.isLeft()) {
    // An Error occurreed
    log(signUpResponse.failureMessage);
    return;
  }

  // The user was successfully signed up
  log(signUpResponse.successResponse.toString());

  ///Response
  ///{message: Email Sent!,
  /// user_record: {
  ///   email_address: akandepeter@gmail.com,
  ///   is_verified: false,
  ///   date_created: 2023-11-11T11:12:48.293571Z,
  ///   first_name: Peter,
  ///   last_name: Akande,
  ///   user_unique_id: dp.ldcaopaggcapepaom
  ///   }
  /// }
}

Future<void> signInUser() async {
  /// Sign In a user
  const emailAddress = 'akandepeter@gmail.com';
  const password = 'Password'; // Optional, Depending on Project Settings

  final signInResponse = await Authivate.instance.signInUser(
    emailAddress: emailAddress,
    password: password,
  );

  if (signInResponse.isLeft()) {
    // An Error occurreed
    log(signInResponse.failureMessage);
    return;
  }

  // The user was successfully signed in
  log(signInResponse.successResponse.toString());

  ///Response
  ///{
  /// user_record: {
  ///   email_address: akandepeter@gmail.com,
  ///   is_verified: false,
  ///   date_created: 2023-11-11T11:12:48.293571Z,
  ///   first_name: Peter,
  ///   last_name: Akande,
  ///   user_unique_id: dp.ldcaopaggcapepaom
  ///   }
  /// }
}

Future<void> sendConfirmAccountEmail() async {
  /// Send a Confirm password email if the original one has expired
  const emailAddress = 'akandepeter@gmail.com';

  final confirmAccountEmailResponse =
      await Authivate.instance.requestOTPForUser(
    emailAddress: emailAddress,
  );

  if (confirmAccountEmailResponse.isLeft()) {
    // An Error occurreed
    log(confirmAccountEmailResponse.failureMessage);
    return;
  }

  // Send a Confirm password email if the original one has expired
  log(confirmAccountEmailResponse.successResponse.toString());

  ///Response
  ///{{message: Email Sent Successfully}
}

Future<void> sendForgotPasswordEmail() async {
  /// Send a forgot password email
  const emailAddress = 'akandepeter@gmail.com';

  final forgotPasswordResponse =
      await Authivate.instance.requestForgotPasswordForUser(
    emailAddress: emailAddress,
  );

  if (forgotPasswordResponse.isLeft()) {
    // An Error occurreed
    log(forgotPasswordResponse.failureMessage);
    return;
  }

  // Forgot password email sebt successfully
  log(forgotPasswordResponse.successResponse.toString());

  ///Response
  /// {message: Forgot Password Email Sent!}
}
