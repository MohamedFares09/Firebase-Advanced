import 'package:firebase_advanced/auth/login_page.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_advanced/widgets/custom_text_field.dart';
import 'package:firebase_advanced/widgets/custom_button.dart';
import 'package:firebase_advanced/widgets/square_tile.dart';
import 'package:firebase_advanced/controllers/auth_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signUp() async {
    if (!_formKey.currentState!.validate()) return;

    final error = await AuthController().signUp(
      _emailController.text,
      _passwordController.text,
    );

    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      if (error == null) {
        Fluttertoast.showToast(
          msg: l10n.emailVerificationSent,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        Fluttertoast.showToast(
          msg: error,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/notes.png', height: 100),
                  const SizedBox(height: 50),
                  Text(
                    l10n.helloThere,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.registerBelow,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CustomTextField(
                      controller: _emailController,
                      hintText: l10n.emailHint,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.emailEmptyError;
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return l10n.emailInvalidError;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CustomTextField(
                      controller: _passwordController,
                      hintText: l10n.passwordHint,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.passwordEmptyError;
                        }
                        if (value.length < 6) {
                          return l10n.passwordLengthError;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: l10n.confirmPasswordHint,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.confirmPasswordEmptyError;
                        }
                        if (value != _passwordController.text) {
                          return l10n.passwordsNotMatchError;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CustomButton(onTap: signUp, text: l10n.signUpButton),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            l10n.orContinueWith,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'G',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              l10n.googleButton,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.iAmAMember,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          l10n.loginNow,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
