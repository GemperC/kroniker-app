import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/backend/records/serializers.dart';
import 'package:koala/pages/home/home_logic.dart';
import 'package:koala/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:koala/widgets/custom/button.dart';

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
          child: Column(
        children: [
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
                    return _buildGameCard(games[index]);
                  },
                );
              },
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildGameCard(GameRecord game) {
    return Card(
      child: ListTile(
        onTap: () {
          // Handle card tap
        },
        leading: game.bannerImageUrl != null
            ? Image.network(game.bannerImageUrl!, fit: BoxFit.cover)
            : Container(color: Colors.blue, width: 50, height: 50),
        title: Text(game.gameTitle ?? 'Unknown Game'),
      ),
    );
  }
}
