import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koala/backend/auth/auth_util.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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
                            _showEditTitleDialog(
                                context, gameProvider.gameRecord);
                          }
                        },
                        child: Text(
                          gameProvider.gameRecord.gameTitle ??
                              'No TItle provided',
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: 200, // Placeholder height for banner image
                      child: InkWell(
                        onLongPress: () {
                          if (isGM) {
                            _uploadImage(context, gameRecord);
                          }
                        },
                        child: gameRecord.bannerImageUrl != null
                            ? Image.network(gameRecord.bannerImageUrl!)
                            : Placeholder(), // Replace with actual image widget
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onLongPress: () {
                          if (isGM) {
                            _showEditDescriptionDialog(
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Characters',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ...List.generate(3,
                        (index) => CharacterCard()), // Generate character cards
                    ListTile(
                      title: Text('GM KIT'),
                      trailing: Checkbox(
                        value: true, // Bind to state variable
                        onChanged: (bool? value) {
                          // Handle change
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 20, top: 20),
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
    );
  }

  Future<void> _uploadImage(BuildContext context, GameRecord game) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Get the file from the image picker
      final file = File(pickedFile.path);

      // Create a reference to the Firebase Storage location
      final storageRef = FirebaseStorage.instance.ref();
      final gameImagesRef =
          storageRef.child('games/${game.id}/${Path.basename(file.path)}');

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

  Future<void> _showEditDescriptionDialog(
      BuildContext context, GameRecord game) async {
    final TextEditingController textController =
        TextEditingController(text: game.description);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Description"),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: "Enter game description",
            ),
            autofocus: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
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
                _updateGameDescription(context, game, textController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTitleDialog(
      BuildContext context, GameRecord game) async {
    final TextEditingController textController =
        TextEditingController(text: game.gameTitle);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Title"),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: "Enter game Title",
            ),
            autofocus: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
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
                _updateGameTitle(context, game, textController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateGameTitle(
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

      // Show the snackbar if still mounted
      if (mounted) {
        ScaffoldMessenger.of(safeContext).showSnackBar(
          SnackBar(content: Text('Game title updated successfully')),
        );
      }
    } catch (e) {
      // Only show the snackbar if still mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update game title')),
        );
      }
    }
  }

  void _updateGameDescription(
      BuildContext context, GameRecord game, String newDescription) async {
    try {
      // Capture a 'safe' context before the async gap
      final safeContext = context;

      // Update the Firestore document
      await FirebaseFirestore.instance.collection('games').doc(game.id).update({
        'description': newDescription,
      });

      // Use the captured 'safe' context
      Provider.of<GameProvider>(safeContext, listen: false)
          .updateGameDescription(newDescription);

      // Show the snackbar if still mounted
      if (mounted) {
        ScaffoldMessenger.of(safeContext).showSnackBar(
          SnackBar(content: Text('Game description updated successfully')),
        );
      }
    } catch (e) {
      // Only show the snackbar if still mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update game description')),
        );
      }
    }
  }
}

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Character Name'), // Bind to character name
        onTap: () {
          // Handle character tap
        },
      ),
    );
  }
}
