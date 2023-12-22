import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/backend/records/serializers.dart';
import 'package:koala/pages/game/game_page.dart';
import 'package:koala/pages/home/home_logic.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:koala/utils/screen_sizes.dart';
import 'package:koala/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('games')
                .orderBy('created_date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) {
                return Center(child: Text("No games available."));
              }

              List<GameRecord> games = snapshot.data!.docs
                  .map((doc) => serializers.deserializeWith(
                      GameRecord.serializer, doc.data()) as GameRecord)
                  .toList();

              return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(top: 80.0)
                        : const EdgeInsets.all(0),
                    child: _buildGameCard(games[index]),
                  );
                },
              );
            },
          ),
          Padding(
              padding: EdgeInsets.only(left: 30, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => onSettingsTap(context),
                    child: Icon(FontAwesomeIcons.gear),
                  ),
                  CustomMainButton(
                    onPressed: () => onCreateGameTap(context),
                    height: 30,
                    buttonText: "Create Game",
                  ),
                ],
              )),
        ],
      )),
    );
  }

  Widget _buildGameCard(GameRecord game) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Card(
        margin: EdgeInsets.only(left: 20, right: 20, top: 25),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 150,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(),
                  ));
              gameProvider.toggleGame(game);
            },
            onLongPress: () {
              _showDeleteGameDialog(context, game);
            },
            child: Container(
              height: 150,
              child: Stack(children: [
                game.bannerImageUrl != null
                    ? Image.network(game.bannerImageUrl!, fit: BoxFit.cover)
                    : Container(color: Colors.blue, width: 100, height: 100),
                Text(game.gameTitle ?? 'Unknown Game')
              ]),
            ),
          ),
        ));
  }

  void _showDeleteGameDialog(BuildContext context, GameRecord game) {
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
                _deleteGame(game);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteGame(GameRecord game) {
    // Assuming game has a unique identifier to reference Firestore document
    FirebaseFirestore.instance
        .collection('games')
        .doc(game.id)
        .delete()
        .then((_) => print('Game deleted'))
        .catchError((error) => print('Delete failed: $error'));
  }
}
