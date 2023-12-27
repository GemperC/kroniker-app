import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/pages/login/login_page.dart';
import 'package:koala/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/dice_provider.dart';
import '../../../utils/theme.dart';
import '../../../widgets/custom/button.dart';
import '../home_logic.dart';

void showDeleteGameDialog(BuildContext context, GameRecord game) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Game"),
        content: Text("Do you want to delete this game?"),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Confirm"),
            onPressed: () {
              deleteGame(game);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showSettingsDialog(BuildContext context) {
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
                      : "Narr-rrative Dice",
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
                      MaterialPageRoute(builder: (context) => LoginWidget()),
                      (route) => false);
                }),
          ],
        ),
      );
    },
  );
}
