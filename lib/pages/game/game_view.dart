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
import 'package:koala/providers/game_provider.dart';
import 'package:koala/utils/theme.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CharacterRecord> characters = [];
  @override
  void initState() {
    super.initState();
    List<CharacterRecord> characters = [];
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final gameRecord = gameProvider.gameRecord;
    final isGM = gameProvider.isGM;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onLongPress: () {
                          if (isGM) {
                            showEditTitleDialog(
                                context, gameProvider.gameRecord);
                          }
                        },
                        child: Text(
                          gameProvider.gameRecord.gameTitle == null ||
                                  gameProvider.gameRecord.gameTitle! == ""
                              ? 'No TItle provided'
                              : gameProvider.gameRecord.gameTitle!,
                          style: AppTypography.title(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: 200, // Placeholder height for banner image
                      child: InkWell(
                        onLongPress: () {
                          if (isGM) {
                            uploadImage(context, gameRecord);
                          }
                        },
                        child: gameRecord.bannerImageUrl != null
                            ? Image.network(gameRecord.bannerImageUrl!)
                            : Placeholder(), // Replace with actual image widget
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                      child: InkWell(
                        onLongPress: () {
                          if (isGM) {
                            showEditDescriptionDialog(
                                context, gameProvider.gameRecord);
                          }
                        },
                        child: Text(
                          gameProvider.gameRecord.description ??
                              'No description provided',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle setting
                          },
                          child: Text('Setting'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle rules
                          },
                          child: Text('Rules'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Characters',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('games')
                            .doc(gameRecord.id)
                            .collection("characters")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData) {
                            return Center(child: Text("No games available."));
                          }

                          List<CharacterRecord> characters = snapshot.data!.docs
                              .map((doc) => serializers.deserializeWith(
                                      CharacterRecord.serializer, doc.data())
                                  as CharacterRecord)
                              .toList();

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: characters.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: index == 0
                                    ? const EdgeInsets.only(top: 80.0)
                                    : const EdgeInsets.all(0),
                                child: buildCharacterCard(
                                    context, characters[index]),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 20, top: 10),
              child: CustomMainButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                height: 30,
                buttonText: "Back",
              ),
            ),
          ],
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
