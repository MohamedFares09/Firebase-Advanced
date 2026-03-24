import 'package:firebase_advanced/home/home_page.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_advanced/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_advanced/widgets/custom_text_field.dart';
import 'package:firebase_advanced/widgets/custom_button.dart';
import 'package:firebase_advanced/widgets/square_tile.dart';
import 'package:firebase_advanced/auth/register_page.dart';
import 'package:firebase_advanced/controllers/auth_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // ================== LOGIN ==================
  Future<void> _login() async {
    final l10n = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final error = await AuthController().signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() => isLoading = false);

    if (error == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      Fluttertoast.showToast(
        msg: error,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // ================== FORGOT PASSWORD ==================
  Future<void> _forgotPassword() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      Fluttertoast.showToast(
        msg: l10n.resetPasswordEmailEmpty,
        backgroundColor: Colors.white,
        textColor: Colors.red,
      );
      return;
    }

    final error = await AuthController().forgetPassword(email);

    if (error == null) {
      Fluttertoast.showToast(
        msg: l10n.resetPasswordSuccess,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: error,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // ================== UI ==================
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // 🌍 Language Switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.language),
                            onSelected: (lang) {
                              MyApp.setLocale(context, Locale(lang));
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'ar', child: Text('العربية')),
                              PopupMenuItem(value: 'en', child: Text('English')),
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      Image.asset('assets/notes.png', height: 100),
                      const SizedBox(height: 30),
                      Text(
                        l10n.welcomeBack,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.weMissedYou,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 40),
                      // Email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: CustomTextField(
                          controller: _emailController,
                          hintText: l10n.emailHint,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.emailEmptyError;
                            }
                            if (!value.contains('@')) return "Invalid email";
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: CustomTextField(
                          controller: _passwordController,
                          hintText: l10n.passwordHint,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.passwordEmptyError;
                            }
                            if (value.length < 6) return "Password too short";
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Forgot password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: _forgotPassword,
                              child: Text(
                                l10n.forgotPassword,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: CustomButton(
                          onTap: isLoading ? () {} : _login,
                          text: l10n.signInButton,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // OR Divider
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[400])),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(l10n.orContinueWith),
                            ),
                            Expanded(child: Divider(color: Colors.grey[400])),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Google Button placeholder
                      SquareTile(
                        onTap: () {},
                        child: Text(l10n.googleButton),
                      ),
                      const SizedBox(height: 30),
                      // Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.notAMember),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(
                              " Register now",
                              style: TextStyle(
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
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}