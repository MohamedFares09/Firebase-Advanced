import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_advanced/home/home_page.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_advanced/widgets/custom_button.dart';
import 'package:firebase_advanced/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key , required this.id});
final String id ;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController note = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final l10n;

  @override
  void didChangeDependencies() {
    l10n = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  addNote() async {
    CollectionReference category = FirebaseFirestore.instance.collection('category').doc(widget.id).collection('note');
    if (formKey.currentState!.validate()) {
      try {
        await category.add({
          'name': note.text,
        });
        Fluttertoast.showToast(msg: "Category Added");
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
                controller: note,
                hintText: l10n.addCategory,
              ),
              SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  addNote();
                },
                text: "Add Note",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
