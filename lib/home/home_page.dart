import 'package:firebase_advanced/auth/login_page.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Text(l10n.homePageTitle),
      ),
      body: Column(children: [Center(child: Text(l10n.welcomeMessage))]),
    );
  }
}
