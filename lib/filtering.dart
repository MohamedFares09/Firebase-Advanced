import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Filtering extends StatefulWidget {
  const Filtering({super.key});

  @override
  State<Filtering> createState() => _FilteringState();
}

class _FilteringState extends State<Filtering> {
  File? file;
  ImagePicker imagePicker = ImagePicker();
  getImage() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      file = File(image.path);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Picker")),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Text(
                "Get Image",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            if (file != null)
              SizedBox(height: 100, width: 100, child: Image.file(file!)),
          ],
        ),
      ),
    );
  }
}
