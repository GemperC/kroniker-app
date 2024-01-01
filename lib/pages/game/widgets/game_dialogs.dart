import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koala/pages/game/game_logic.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:provider/provider.dart';

import '../../../backend/records/game_record.dart';

void showGMKitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("GM Kit"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                showAddCharacterDialog(context);
              },
              child: Text('Add Character'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                showAddPlayerDialog(context);
              },
              child: Text('Players'),
            ),
          ],
        ),
      );
    },
  );
}

void showAddPlayerDialog(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  String gameId =
      Provider.of<GameProvider>(context, listen: false).gameRecord.id!;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Players"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: "Add Player's email"),
                  ),
                ),
                TextButton(
                  child: Text("Add"),
                  onPressed: () async {
                    String email = emailController.text.trim();
                    final gameDoc = await FirebaseFirestore.instance
                        .collection('games')
                        .doc(gameId);
                    await gameDoc.update({
                      'userEmails': FieldValue.arrayUnion([email])
                    });
                    emailController.text = '';

                    emailController.clear();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('games')
                  .doc(gameId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  return Center(child: Text("No data found."));
                }
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                List<dynamic> userEmails = data['userEmails'] ?? [];

                if (data['userEmails'] == null) {
                  return Center(child: Text("No players found."));
                }

                return Column(
                  children:
                      List<Widget>.from(userEmails.map((email) => Text(email))),
                );
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Exit"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showAddCharacterDialog(BuildContext context) {
  TextEditingController nameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Character"),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: "Enter character name"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Add"),
            onPressed: () async {
              String name = nameController.text.trim();
              if (name.isNotEmpty) {
                // Create character data
                Map<String, dynamic> characterData = {
                  'name': name,
                  'createdDate':
                      DateTime.now(), // Add other fields as necessary
                };

                // Add character to Firestore
                await FirebaseFirestore.instance
                    .collection(
                        'games/${Provider.of<GameProvider>(context, listen: false).gameRecord.id}/characters')
                    .add(characterData);

                // Optionally, show a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Character added successfully')),
                );

                Navigator.of(context).pop(); // Close the dialog
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> showEditDescriptionDialog(
    BuildContext context, GameRecord game) async {
  final TextEditingController textController =
      TextEditingController(text: game.description);

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Edit Description"),
        content: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            hintText: "Enter game description",
            border: InputBorder.none,
            filled: true,
          ),
          autofocus: true,
          keyboardType: TextInputType.multiline,
          maxLines: 99,
          minLines: 6,
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
              updateGameDescription(context, game, textController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showEditTitleDialog(BuildContext context, GameRecord game) async {
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
              updateGameTitle(context, game, textController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
