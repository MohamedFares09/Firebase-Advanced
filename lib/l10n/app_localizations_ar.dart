// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcomeBack => 'مرحباً بعودتك!';

  @override
  String get weMissedYou => 'لقد افتقدناك';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get emailEmptyError => 'يرجي ادخال البريد الالكتروني';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get passwordEmptyError => 'يرجي ادخال كلمة المرور';

  @override
  String get signInButton => 'تسجيل الدخول';

  @override
  String get orContinueWith => 'أو المتابعة باستخدام';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get resetPasswordEmailEmpty => 'يرجي ادخال البريد الالكتروني';

  @override
  String get resetPasswordSuccess =>
      'تم ارسال رابط اعادة تعيين كلمة المرور بنجاح';

  @override
  String get notAMember => 'لست عضواً؟';

  @override
  String get registerNow => ' سجل الآن';

  @override
  String get googleButton => 'جوجل';

  @override
  String get helloThere => 'مرحباً بك!';

  @override
  String get registerBelow => 'سجل أدناه باستخدام بياناتك';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordEmptyError => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsNotMatchError => 'كلمات المرور غير متطابقة';

  @override
  String get passwordLengthError =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get emailInvalidError => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get signUpButton => 'تسجيل حساب';

  @override
  String get emailVerificationSent => 'تم إرسال بريد التحقق';

  @override
  String get iAmAMember => 'أنا عضو بالفعل!';

  @override
  String get loginNow => ' تسجيل الدخول';
}
