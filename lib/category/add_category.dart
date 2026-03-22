import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_advanced/widgets/custom_button.dart';
import 'package:firebase_advanced/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final l10n;

  @override
  void didChangeDependencies() {
    l10n = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addCategory)),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            CustomTextField(controller: controller, hintText: l10n.addCategory),
            SizedBox(height: 20),
            CustomButton(onTap: () {}, text: l10n.addCategory),
          ],
        ),
      ),
    );
  }
}
