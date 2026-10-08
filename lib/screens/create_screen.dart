import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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


  Future<void> createPost() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sign in before posting.'),
        ),
      );
      return;
    }

    final file = selectedFile;
    if (file == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a photo or video first.'),
        ),
      );
      return;
    }

    setState(() {
      uploading = true;
    });

    try {
      final fileName = file.path
          .split(Platform.pathSeparator)
          .last
          .replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final storagePath =
          'posts/${user.uid}/${timestamp}_$fileName';

      final storageRef =
          FirebaseStorage.instance.ref().child(storagePath);

      final metadata = SettableMetadata(
        contentType: isVideo ? 'video/mp4' : 'image/jpeg',
      );

      await storageRef.putFile(file, metadata);

      final mediaUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('posts').add({
        'userId': user.uid,
        'caption': captionController.text.trim(),
        'mediaUrl': mediaUrl,
        'mediaType': isVideo ? 'video' : 'image',
        'createdAt': FieldValue.serverTimestamp(),
        'likes': 0,
        'comments': 0,
      });

      if (!mounted) return;

      captionController.clear();

      setState(() {
        selectedFile = null;
        isVideo = false;
        uploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post published successfully.'),
        ),
      );
    } on FirebaseException catch (e) {
      if (!mounted) return;

      setState(() {
        uploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'Unable to publish the post.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        uploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to publish the post. Please try again.'),
        ),
      );
    }
  }


}
