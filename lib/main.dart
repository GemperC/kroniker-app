import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koala/providers/dice_provider.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:koala/providers/theme_provider.dart';
import 'package:koala/providers/character_provider.dart';

import 'package:koala/utils/theme.dart';
import 'package:koala/utils/utils.dart';
import 'package:koala/pages/home/home_view.dart';
import 'package:koala/pages/login/login_page.dart';
import 'package:provider/provider.dart';

import 'backend/auth/auth_util.dart';
import 'backend/auth/firebase_user_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => DiceProvider()),
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();

  late Stream<LoginFirebaseUser> userStream;
  LoginFirebaseUser? initialUser;
  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    userStream = loginFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    storage.writeIfNull('theme', ThemeMode.dark.toString());
    storage.writeIfNull('narrative_dice', true);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        theme: AppColors.LightTheme,
        darkTheme: AppColors.DarkTheme,
        themeMode: themeProvider.themeMode,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.messengerKey,
        home: (currentUser != null && currentUser!.loggedIn)
            ? HomeWidget()
            : LoginWidget());
  }
}
