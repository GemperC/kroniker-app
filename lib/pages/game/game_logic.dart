import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/pages/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koala/pages/login/login_page.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../backend/auth/google_auth.dart';
import '../../utils/utils.dart';
import '../../widgets/route/route_widget.dart';
import 'game_model.dart';
import 'package:path/path.dart' as Path;

Future<void> uploadImage(BuildContext context, GameRecord game) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    // Get the file from the image picker
    final file = File(pickedFile.path);

    // Create a reference to the Firebase Storage location
    final storageRef = FirebaseStorage.instance.ref();
    final gameImagesRef =
        storageRef.child('games/${game.id}/banner/${Path.basename(file.path)}');

    // Upload the file
    await gameImagesRef.putFile(file);

    // Get the download URL
    final downloadUrl = await gameImagesRef.getDownloadURL();

    // Update the GameRecord's bannerImageUrl with the new URL
    await FirebaseFirestore.instance.collection('games').doc(game.id).update({
      'bannerImageUrl': downloadUrl,
    });

    // Update the local game record state and notify listeners
    Provider.of<GameProvider>(context, listen: false)
        .updateGameBannerUrl(downloadUrl);

    // Optionally, show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Banner image updated successfully')),
    );
  }
}

void updateGamePlayers(
    BuildContext context, GameRecord game, String newPlayer) async {
  try {
    // Update the Firestore document
    await FirebaseFirestore.instance.collection('games').doc(game.id).update({
      'userEmails': FieldValue.arrayUnion([newPlayer]),
    });
  } catch (e) {}
}

void updateGameTitle(
    BuildContext context, GameRecord game, String newGameTitle) async {
  try {
    // Capture a 'safe' context before the async gap
    final safeContext = context;

    // Update the Firestore document
    await FirebaseFirestore.instance.collection('games').doc(game.id).update({
      'gameTitle': newGameTitle,
    });

    // Use the captured 'safe' context
    Provider.of<GameProvider>(safeContext, listen: false)
        .updateGameTitle(newGameTitle);
  } catch (e) {}
}

void updateGameDescription(
    BuildContext context, GameRecord game, String newDescription) async {
  try {
    await FirebaseFirestore.instance.collection('games').doc(game.id).update({
      'description': newDescription,
    });

    Provider.of<GameProvider>(context, listen: false)
        .updateGameDescription(newDescription);
  } catch (e) {}
}

void updateGameSetting(
    BuildContext context, GameRecord game, String newSetting) async {
  try {
    await FirebaseFirestore.instance.collection('games').doc(game.id).update({
      'setting': newSetting,
    });

    Provider.of<GameProvider>(context, listen: false)
        .updateGameSetting(newSetting);
  } catch (e) {}
}

void uploadPDF(BuildContext context, String gameId) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    String fileName = 'rules/rules.pdf'; // Customize as needed

    try {
      await FirebaseStorage.instance
          .ref('games/$gameId/$fileName')
          .putFile(file);

      // Get download URL and update Firestore document
      String downloadURL = await FirebaseStorage.instance
          .ref('games/$gameId/$fileName')
          .getDownloadURL();

      await FirebaseFirestore.instance
          .collection('games')
          .doc(gameId)
          .update({'rulesUrl': downloadURL});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload PDF')),
      );
    }
  }
}
