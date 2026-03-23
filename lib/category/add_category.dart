import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_advanced/widgets/custom_button.dart';
import 'package:firebase_advanced/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final l10n;
  CollectionReference category = FirebaseFirestore.instance.collection(
    'category',
  );
  @override
  void didChangeDependencies() {
    l10n = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  addCategory() async {
    if (formKey.currentState!.validate()) {
      try {
        await category.add({'name': controller.text});
        Fluttertoast.showToast(
          msg: "Category Added",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addCategory)),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              CustomTextField(controller: controller, hintText: l10n.addCategory),
              SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  addCategory();
                },
                text: l10n.addCategory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
