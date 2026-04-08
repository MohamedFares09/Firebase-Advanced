import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_advanced/note/note.dart';
import 'package:firebase_advanced/widgets/custom_button.dart';
import 'package:firebase_advanced/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateNote extends StatefulWidget {
  const UpdateNote({super.key, required this.id, required this.noteId, required this.oldNote});
  final String id;
  final String noteId;
  final String oldNote;

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final l10n;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    l10n = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  updateNote() async {
    if (formKey.currentState!.validate()) {
      try {   
        isLoading = true;
        setState(() {});

        await FirebaseFirestore.instance
            .collection('category')
            .doc(widget.id)
            .collection('note')
            .doc(widget.noteId)
            .update({
          'name': controller.text,
        });

        Fluttertoast.showToast(msg: "Note Updated");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NotePage(id: widget.id)),
        );
      } on Exception catch (e) {
        print(e);
      } finally {
        isLoading = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    controller.text = widget.oldNote;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addCategory),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                    const SizedBox(height: 20),
                    CustomButton(
                      onTap: () {
                        updateNote();
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
