import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_advanced/auth/login_page.dart';
import 'package:firebase_advanced/category/add_category.dart';
import 'package:firebase_advanced/category/update_category.dart';
import 'package:firebase_advanced/l10n/app_localizations.dart';
import 'package:firebase_advanced/note/note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List data = [];
  getData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('category')
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      data.addAll(snapshot.docs);
      Future.delayed(Duration(seconds: 2));
      isLoading = false;
      setState(() {});
    }
  }

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
            MaterialPageRoute(builder: (context) => const AddCategory()),
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
        title: Text(l10n.homePageTitle),
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
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return NotePage(id : data[index].id);
                    }));
                  },
                  onLongPress: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Wrong'),
                          // content: Text(
                          //   'Are you sure you want to delete this category?',
                          // ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateCategory(
                                      id: data[index].id,
                                      oldName: data[index]['name'],
                                    ),
                                  ),
                                );
                              },
                              child: Text('Update'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('category')
                                    .doc(data[index].id)
                                    .delete();

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                                Fluttertoast.showToast(
                                  msg: 'Category deleted successfully',
                                );
                              },
                              child: Text('Delete'),
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
                      child: Column(
                        children: [
                          Image.asset('assets/folder.png', height: 100),
                          Text(data[index]['name']),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
