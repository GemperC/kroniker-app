import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koala/backend/auth/auth_util.dart';
import 'package:koala/backend/auth/google_auth.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/pages/login/login_page.dart';
import 'package:koala/providers/dice_provider.dart';
import 'package:koala/providers/theme_provider.dart';
import 'package:koala/utils/theme.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:koala/widgets/custom/textfield.dart';
import 'package:provider/provider.dart';

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
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  final diceProvider = Provider.of<DiceProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "The why is this a dialog but here is\nsome settings dialog",
              style: AppTypography.dialogTitle(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            CustomMainButton(
              buttonText:
                  Provider.of<DiceProvider>(context, listen: true).narrativeDice
                      ? "Manual Dice"
                      : "Narrative Dice",
              onPressed: () {
                diceProvider.toggleDiceMode();
              },
            ),
            themeProvider.themeMode == ThemeMode.dark
                ? CustomMainButton(
                    buttonText: "Angelic Theme",
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  )
                : CustomMainButton(
                    buttonText: "Underdark Theme",
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  ),
            CustomMainButton(
              buttonText: "Get me outta here NOW",
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginWidget(),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
      );
    },
  );
}
