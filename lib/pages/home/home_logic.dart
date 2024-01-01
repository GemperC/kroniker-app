import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koala/backend/auth/auth_util.dart';
import 'package:koala/backend/auth/google_auth.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/pages/home/widgets/home_dialogs.dart';
import 'package:koala/pages/login/login_page.dart';
import 'package:koala/providers/dice_provider.dart';
import 'package:koala/providers/theme_provider.dart';
import 'package:koala/utils/theme.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:koala/widgets/custom/textfield.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

void onCreateGameTap(context) {
  final gameNameController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Create new game",
              style: AppTypography.dialogTitle(context),
            ),
            SizedBox(height: 10),
            CustomTextField(
              textField: TextField(
                controller: gameNameController,
              ),
            ),
            SizedBox(height: 10),
            CustomMainButton(
              buttonText: "Add",
              onPressed: () {
                createNewGame(gameNameController.text.trim());
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}

void createNewGame(String gameTitle) async {
  try {
    DateTime createdDate = DateTime.now();
    String gameMasterEmail = currentUserDocument!.email!;
    BuiltList<String> userEmails = BuiltList<String>([
      gameMasterEmail
    ]); // Create a BuiltList containing the game master's email

    Map<String, dynamic> gameData = GameRecord().createGameRecordData(
      gameTitle: gameTitle,
      createdDate: createdDate,
      gameMasterEmail: gameMasterEmail,
      userEmails: userEmails,
    );

    GameRecord().addNewGame(gameData);
    print("Game record created successfully.");
  } catch (e) {
    print("Error creating game record: $e");
  }
}

void deleteGame(GameRecord game) {
  // Assuming game has a unique identifier to reference Firestore document
  FirebaseFirestore.instance
      .collection('games')
      .doc(game.id)
      .delete()
      .then((_) => print('Game deleted'))
      .catchError((error) => print('Delete failed: $error'));
}

void onSettingsTap(context) {
  showSettingsDialog(context);
}
