import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/backend/records/serializers.dart';
import 'package:koala/pages/game/game_view.dart';
import 'package:koala/pages/home/home_logic.dart';
import 'package:koala/pages/home/widgets/game_card_widget.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:koala/utils/screen_sizes.dart';
import 'package:koala/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    child: buildGameCard(context, games[index]),
                  );
                },
              );
            },
          ),
          topBar(),
        ],
      )),
    );
  }

  Widget topBar() {
    return Padding(
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
        ));
  }
}
