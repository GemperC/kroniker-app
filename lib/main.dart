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
            ? HomeScreen()
            : LoginWidget());
  }
}




// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:koala/backend/auth/bloc/auth_bloc.dart';
// import 'package:koala/providers/dice_provider.dart';
// import 'package:koala/providers/game_provider.dart';
// import 'package:koala/providers/theme_provider.dart';
// import 'package:koala/providers/character_provider.dart';
// import 'package:koala/utils/theme.dart';
// import 'package:koala/pages/home/home_view.dart';
// import 'package:koala/pages/login/login_page.dart';
// import 'package:koala/utils/utils.dart';
// import 'package:provider/provider.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await GetStorage.init();
//   final storage = GetStorage();
//   storage.writeIfNull('theme', ThemeMode.dark.toString());
//   storage.writeIfNull('narrative_dice', true);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => ThemeProvider()),
//         ChangeNotifierProvider(create: (context) => DiceProvider()),
//         ChangeNotifierProvider(create: (context) => GameProvider()),
//         ChangeNotifierProvider(create: (context) => CharacterProvider()),
//       ],
//       child: BlocProvider(
//         create: (_) => AuthBloc(FirebaseAuth.instance)..add(AppStarted()),
//         child: AppView(),
//       ),
//     );
//   }
// }

// class AppView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return MaterialApp(
//       theme: AppColors.LightTheme,
//       darkTheme: AppColors.DarkTheme,
//       themeMode: themeProvider.themeMode,
//       debugShowCheckedModeBanner: false,
//       scaffoldMessengerKey: Utils.messengerKey,
//       home: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) {
//           if (state is AuthAuthenticated) {
//             return HomeScreen();
//           }
//           return LoginWidget();
//         },
//       ),
//     );
//   }
// }
