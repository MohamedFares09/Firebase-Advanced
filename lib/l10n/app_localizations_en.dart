// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get weMissedYou => 'We\'ve missed you';

  @override
  String get emailHint => 'Email';

  @override
  String get emailEmptyError => 'Please enter your email';

  @override
  String get passwordHint => 'Password';

  @override
  String get passwordEmptyError => 'Please enter your password';

  @override
  String get signInButton => 'Sign In';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get resetPasswordEmailEmpty =>
      'Please enter your email to reset password';

  @override
  String get resetPasswordSuccess =>
      'Password reset link sent! Check your email.';

  @override
  String get notAMember => 'Not a member?';

  @override
  String get registerNow => ' Register now';

  @override
  String get googleButton => 'Google';

  @override
  String get helloThere => 'Hello There!';

  @override
  String get registerBelow => 'Register below with your details';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get confirmPasswordEmptyError => 'Please confirm your password';

  @override
  String get passwordsNotMatchError => 'Passwords do not match';

  @override
  String get passwordLengthError => 'Password must be at least 6 characters';

  @override
  String get emailInvalidError => 'Please enter a valid email';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get emailVerificationSent => 'Email Verification Sent';

  @override
  String get iAmAMember => 'I am a member!';

  @override
  String get loginNow => ' Login now';

  @override
  String get homePageTitle => 'Home Page';

  @override
  String get welcomeMessage => 'Welcome';

  @override
  String get addCategory => 'Add Category';
}
