import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/pages/game/game_logic.dart';
import 'package:koala/utils/screen_sizes.dart';

void showGameSettingDialog(
    BuildContext context, GameRecord gameRecord, bool isGM) {
  TextEditingController settingsController =
      TextEditingController(text: gameRecord.setting);
  showDialog(
    context: context,
    builder: (context) {
      bool isEditingMode = false; // Local state for editing mode
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20),
            title: Center(child: Text('World Setting')),
            content: Container(
              height: ScreenInfo(context).screenHeight,
              width: ScreenInfo(context).screenWidth,
              child: SingleChildScrollView(
                child: InkWell(
                  onLongPress: () {
                    if (isGM) {
                      setState(() {
                        isEditingMode = true; // Update local state
                      });
                    }
                  },
                  child: isEditingMode
                      ? TextFormField(
                          controller: settingsController,
                          decoration: InputDecoration(
                              border: InputBorder.none, filled: true),
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: 1000,
                          minLines: 6,
                        )
                      : Text(gameRecord.setting ?? "No setting provided"),
                ),
              ),
            ),
            actions: isEditingMode
                ? [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        setState(() {
                          isEditingMode = false; // Revert back to view mode
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Save'),
                      onPressed: () {
                        updateGameSetting(
                            context, gameRecord, settingsController.text);
                        Navigator.of(context).pop();
                      },
                    ),
                  ]
                : [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
          );
        },
      );
    },
  );
}
