import 'package:flutter/material.dart';
import 'package:koala/providers/theme_provider.dart';
import 'package:koala/utils/theme.dart';
import 'package:koala/widgets/custom/model.dart';
import 'package:koala/pages/login/login_model.dart';
import 'package:provider/provider.dart';

import '../../utils/screen_sizes.dart';
import '../../utils/utils.dart';
import '../../widgets/custom/button.dart';
import '../../widgets/custom/quarter_circle.dart';
import '../../widgets/custom/ring.dart';
import '../../widgets/custom/textfield.dart';
import 'login_logic.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => LoginModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: ScreenInfo(context).screenHeight,
          width: ScreenInfo(context).screenWidth,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text("Kroniker Offical App for Lols and Absurdity")),
                Padding(
                    padding: EdgeInsets.only(bottom: 80), child: Text("KOALA")),
                ElevatedButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    child: Text("")),
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20, bottom: 80),
                  child: Container(
                    alignment: Alignment.center,
                    child: loginButton(),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget loginButton() {
    return CustomMainButton(
      buttonText: "Login With Google",
    );
  }
}
