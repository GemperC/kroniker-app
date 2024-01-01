import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koala/backend/auth/auth_util.dart';
import 'package:koala/backend/records/character_record.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/backend/records/serializers.dart';
import 'package:koala/pages/game/game_logic.dart';
import 'package:koala/pages/game/widgets/character_card.dart';
import 'package:koala/pages/game/widgets/game_dialogs.dart';
import 'package:koala/pages/game/widgets/rules_dialog.dart';
import 'package:koala/pages/game/widgets/setting_dialog.dart';
import 'package:koala/pages/home/widgets/home_dialogs.dart';
import 'package:koala/providers/character_provider.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:koala/utils/theme.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:provider/provider.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final characterProvider = Provider.of<CharacterProvider>(context);

    final gameRecord = gameProvider.gameRecord;
    final characterRecord = characterProvider.currentCharacter!;

    final isGM = gameProvider.isGM;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [Text(characterRecord.name ?? "No name")],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: isGM
          ? FloatingActionButton(
              child: Text(
                "GM\nKIT",
                textAlign: TextAlign.center,
                style: AppTypography.floatingButtonText(context),
              ),
              onPressed: () {
                showGMKitDialog(context);
              },
            )
          : Container(),
    );
  }
}
