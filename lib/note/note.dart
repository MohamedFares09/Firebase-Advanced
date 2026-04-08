import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_advanced/auth/login_page.dart';
import 'package:firebase_advanced/home/home_page.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_advanced/note/add_note.dart';
import 'package:firebase_advanced/note/update_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.id});
  final String id;
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool isLoading = true;
  List data = [];
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc(widget.id)
        .collection("note")
        .get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  deleteData() {}

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNote(id: widget.id)),
          );
        },
        child: Icon(Icons.add),
      ),
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
        title: Text("Note"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 160,
              ),

              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Wrong"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => UpdateNote(
                                      oldNote: data[index]['name'],
                                      id: widget.id,
                                      noteId: data[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Text("update"),
                            ),
                            TextButton(
                              onPressed: () async {
                                isLoading = true;
                                setState(() {});
                                try {
                                  await FirebaseFirestore.instance
                                      .collection("category")
                                      .doc(widget.id)
                                      .collection('note')
                                      .doc(data[index].id)
                                      .delete();
                                  isLoading = false;
                                  setState(() {});
                                  print('Success ========================');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return HomePage();
                                      },
                                    ),
                                  );
                                } on Exception catch (e) {
                                  print("================================= $e");
                                  isLoading = false;
                                  setState(() {});
                                }
                              },
                              child: Text("delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(children: [Text(data[index]['name'])]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
