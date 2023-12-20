import 'package:flutter/material.dart';
import 'package:koala/backend/auth/auth_util.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/utils/theme.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:koala/widgets/custom/textfield.dart';

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
    Map<String, dynamic> gameData = GameRecord().createGameRecordData(
      gameTitle: gameTitle,
      createdDate: createdDate,
      gameMasterEmail: gameMasterEmail,
    );

    GameRecord().addNewGame(gameData);
    print("Game record created successfully.");
  } catch (e) {
    print("Error creating game record: $e");
  }
}

void onSettingsTap(context) {
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
          ],
        ),
      );
    },
  );
}
