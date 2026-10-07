import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class CreateScreen extends StatefulWidget {

  const CreateScreen({super.key});

  @override

  State<CreateScreen> createState() => _CreateScreenState();

}

class _CreateScreenState extends State<CreateScreen> {

  final ImagePicker picker = ImagePicker();

  final TextEditingController captionController = TextEditingController();

  File? selectedFile;

  bool isVideo = false;

  bool uploading = false;

  Future<void> pickPhoto() async {

    final XFile? file = await picker.pickImage(

      source: ImageSource.gallery,

      imageQuality: 85,

    );

    if (file == null) return;

    setState(() {

      selectedFile = File(file.path);

      isVideo = false;

    });

  }

  Future<void> pickVideo() async {

    final XFile? file = await picker.pickVideo(

      source: ImageSource.gallery,

    );

    if (file == null) return;

    setState(() {

      selectedFile = File(file.path);

      isVideo = true;

    });

  }

  

  @override

  void dispose() {

    captionController.dispose();

    super.dispose();

  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(

        backgroundColor: Colors.black,

        title: const Text(

          'Create',

          style: TextStyle(fontWeight: FontWeight.bold),

        ),

        centerTitle: true,

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            if (selectedFile != null)

              Container(

                height: 300,

                margin: const EdgeInsets.only(bottom: 20),

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(color: Colors.deepPurple),

                ),

                clipBehavior: Clip.antiAlias,

                child: isVideo

                    ? const Center(

                        child: Icon(

                          Icons.video_library,

                          size: 80,

                          color: Colors.deepPurple,

                        ),

                      )

                    : Image.file(

                        selectedFile!,

                        fit: BoxFit.cover,

                      ),

              ),

            TextField(

              controller: captionController,

              maxLines: 5,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(

                hintText: 'What do you want to share?',

                hintStyle: const TextStyle(color: Colors.grey),

                filled: true,

                fillColor: Colors.white10,

                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(18),

                  borderSide: BorderSide.none,

                ),

              ),

            ),

            const SizedBox(height: 20),

            Row(

              children: [

                Expanded(

                  child: ElevatedButton.icon(

                    onPressed: uploading ? null : pickPhoto,

                    icon: const Icon(Icons.photo),

                    label: const Text('Photo'),

                  ),

                ),

                const SizedBox(width: 12),

                Expanded(

                  child: ElevatedButton.icon(

                    onPressed: uploading ? null : pickVideo,

                    icon: const Icon(Icons.videocam),

                    label: const Text('Video'),

                  ),

                ),

              ],

            ),

            const SizedBox(height: 25),

            SizedBox(

              height: 55,

              child: ElevatedButton(

                onPressed: uploading ? null : createPost,

                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.deepPurple,

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(18),

                  ),

                ),

                child: uploading

                    ? const CircularProgressIndicator(

                        color: Colors.white,

                      )

                    : const Text(

                        'POST',

                        style: TextStyle(

                          fontSize: 17,

                          fontWeight: FontWeight.bold,

                        ),

                      ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}