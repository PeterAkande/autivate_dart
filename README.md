# Authivate

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

The Dart SDK for the [Authivate]('https://authivate.com') service
Authivate is 
## Installation 💻

**❗ In order to start using Authivate you must have the [Dart SDK][dart_install_link] installed on your machine.**

Install via `dart pub add`:

```sh
dart pub add authivate
```

---
## Example Usage
```dart
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


```





[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
