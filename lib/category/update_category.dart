import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_advanced/home/home_page.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_advanced/widgets/custom_button.dart';
import 'package:firebase_advanced/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateCategory extends StatefulWidget {
  const UpdateCategory({super.key, required this.id, required this.oldName});
  final String id;
  final String oldName;
  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
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

  updateCategory() async {
    if (formKey.currentState!.validate()) {
      try {
        await category.doc(widget.id).update({
          'name': controller.text,
        });
        Fluttertoast.showToast(msg: "Category Updated");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } on Exception catch (e) {
        print(e);
      }
    }
  }
@override
  void initState() {
    controller.text = widget.oldName;
    super.initState();
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
              CustomTextField(
                controller: controller,
                hintText: l10n.addCategory,
              ),
              SizedBox(height: 20),
              CustomButton(
                onTap: () {
                    updateCategory();
                },
                text: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
